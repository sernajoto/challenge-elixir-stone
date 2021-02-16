defmodule ChallengeTest do
  use ExUnit.Case

  test "should return email map" do
    emails = ["test1@test.com", "test2@test.com"]
    items = [%{name: "test1", price: 10, qty: 3}, %{name: "test2", price: 25, qty: 2}, %{name: "test3", price: 5, qty: 4}]
    assert Challenge.calculate(items, emails) == %{"test1@test.com": 50, "test2@test.com": 50}
  end

  test "should return email map with non-whole division" do
    emails = ["test1@test.com", "test2@test.com", "test3@test.com"]
    items = [%{name: "test1", price: 10, qty: 3}, %{name: "test2", price: 25, qty: 2}, %{name: "test3", price: 5, qty: 4}]
    assert Challenge.calculate(items, emails) == %{"test1@test.com": 34, "test2@test.com": 33, "test3@test.com": 33}
  end

  test "should return email map with no duplicate emails" do
    emails = ["test1@test.com", "test2@test.com", "test1@test.com"]
    items = [%{name: "test1", price: 10, qty: 3}, %{name: "test2", price: 25, qty: 2}, %{name: "test3", price: 5, qty: 4}]
    assert Challenge.calculate(items, emails) == %{"test1@test.com": 50, "test2@test.com": 50}
  end

  test "should return email map with zero value" do
    emails = ["test1@test.com", "test2@test.com"]
    items = []
    assert Challenge.calculate(items, emails) == %{"test1@test.com": 0, "test2@test.com": 0}
  end

  test "should raise empty email list error" do
    emails = []
    items = [%{name: "test1", price: 10, qty: 3}]
    assert_raise RuntimeError, "Email list is empty!", fn -> Challenge.calculate(items, emails) end
  end
end
