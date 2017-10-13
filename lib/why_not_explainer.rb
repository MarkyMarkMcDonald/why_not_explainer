require 'why_not_explainer/version'
require 'ostruct'

module WhyNotExplainer
  def self.why_not?(relation, id)
    if relation.where(id: id).exists?
      "A '#{relation.name}' with id of #{id} was found by the relation"
    else
      equality_nodes = relation.arel.constraints[0].children.dup
      culprit_nodes = equality_nodes.select do |equality_node|
        relation.instance_variable_set(:@to_sql, nil)
        relation.arel.constraints[0].children.clear

        relation.arel.constraints[0].children << equality_node
        relation.arel.constraints[0].children << relation.table[:id].eq(id)

        result = ActiveRecord::Base.connection.execute(relation.to_sql)
        result.empty?
      end

      culprits = culprit_nodes.map do |culprit|
        bind_value = relation.bind_values.find do |value|
          value[0].name == culprit.left.name
        end
        Culprit.new(constraint: culprit.left.name, value: bind_value[1])
      end

      "not included because of constraints: [#{culprits.map(&:to_s).join(', ')}]"
    end
  end

  class Culprit
    def initialize(constraint:, value:)
      @constraint = constraint
      @value = value
    end

    def to_s
      "'where #{@constraint}: #{@value}'"
    end
  end
end
