require 'test_helper'
require_relative '../lib/examples/car'

class WhyNotExplainerTest < Minitest::Test
  def before_setup
    Car.delete_all
  end

  def test_why_not_eh_when_it_is_included
    car = Car.create(name: 'Toyota Camry', year: 2010)

    relation = Car.all

    result = WhyNotExplainer.why_not?(relation, car.id)
    assert_equal("A 'Car' with id of #{car.id} was found by the relation", result.to_s)
  end

  def test_why_not_eh_when_it_is_not_included
    car = Car.create(name: 'Toyota Camry', year: 2010)

    relation = Car.where(year: 2009)

    result = WhyNotExplainer.why_not?(relation, car.id)
    assert_equal("not included because of constraints: ['where year: 2009']", result.to_s)
  end

  def test_why_not_eh_when_it_is_not_included_by_only_one_where_clause
    car = Car.create(name: 'Toyota Camry', year: 2010)

    relation = Car.where(year: 2010).where(name: 'Camry T')

    result = WhyNotExplainer.why_not?(relation, car.id)
    assert_equal("not included because of constraints: ['where name: Camry T']", result.to_s)
  end

  def test_why_not_eh_when_it_is_not_included_by_more_than_one_where_clause
    car = Car.create(name: 'Toyota Camry', year: 2010)

    relation = Car.where(year: 2009).where(name: 'Camry T')

    result = WhyNotExplainer.why_not?(relation, car.id)
    assert_equal("not included because of constraints: ['where year: 2009', 'where name: Camry T']", result.to_s)
  end

  def test_why_not_eh_when_rows_are_found_but_not_the_needle
    old_car = Car.create(name: 'Toyota Camry', year: 2008)
    _new_car = Car.create(name: 'Toyota Camry', year: 2009)

    relation = Car.where(year: 2009)

    result = WhyNotExplainer.why_not?(relation, old_car.id)

    assert_equal("not included because of constraints: ['where year: 2009']", result.to_s)
  end
end
