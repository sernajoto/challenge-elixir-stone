defmodule ChallengeTest do
  use ExUnit.Case

  describe "calculate/2" do
    test "returns email map" do
      emails = ["test1@test.com", "test2@test.com"]

      items = [
        %{name: "test1", price: 10, qty: 3},
        %{name: "test2", price: 25, qty: 2},
        %{name: "test3", price: 5, qty: 4}
      ]

      response = Challenge.calculate(items, emails)

      expected_response = %{"test1@test.com": 50, "test2@test.com": 50}

      assert response == expected_response
    end

    test "returns email map with non-whole division" do
      emails = ["test1@test.com", "test2@test.com", "test3@test.com"]

      items = [
        %{name: "test1", price: 10, qty: 3},
        %{name: "test2", price: 25, qty: 2},
        %{name: "test3", price: 5, qty: 4}
      ]

      response = Challenge.calculate(items, emails)

      expected_response = %{"test1@test.com": 34, "test2@test.com": 33, "test3@test.com": 33}

      assert response == expected_response
    end

    test "returns email map with no duplicate emails" do
      emails = ["test1@test.com", "test2@test.com", "test1@test.com"]

      items = [
        %{name: "test1", price: 10, qty: 3},
        %{name: "test2", price: 25, qty: 2},
        %{name: "test3", price: 5, qty: 4}
      ]

      response = Challenge.calculate(items, emails)

      expected_response = %{"test1@test.com": 50, "test2@test.com": 50}

      assert response == expected_response
    end

    test "returns email map with zero value" do
      emails = ["test1@test.com", "test2@test.com"]
      items = []

      response = Challenge.calculate(items, emails)

      expected_response = %{"test1@test.com": 0, "test2@test.com": 0}

      assert response == expected_response
    end

    test "returns empty email list error" do
      emails = []
      items = [%{name: "test1", price: 10, qty: 3}]

      response = Challenge.calculate(items, emails)

      expected_response = {:error, "Email list is empty!"}

      assert response == expected_response
    end
  end
end
