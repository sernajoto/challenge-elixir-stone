defmodule Challenge do
  def calculate(items, emails) do
    if Enum.empty?(emails) do
      raise "Email list is empty!"
    end
    total = Enum.reduce(items, 0, fn(item, acc) -> item.price * item.qty + acc end)
    emails = Enum.uniq(emails)
    qty_emails = length(emails)
    div = div(total, qty_emails)
    rem = rem(total, qty_emails)
    emails_pay_more = if rem > 0, do: Enum.map(Enum.slice(emails, 0..rem-1), fn(email) -> %{"#{email}": div+1} end), else: []
    emails_remaining = Enum.map(Enum.slice(emails, rem..qty_emails-1), fn(email) -> %{"#{email}": div} end)
    Enum.reduce(emails_pay_more ++ emails_remaining, %{}, fn(map_item, acc) -> Map.merge(map_item, acc) end)
  end
end