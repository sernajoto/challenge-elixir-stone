defmodule Challenge do
  def calculate(_items, []), do: {:error, "Email list is empty!"}

  def calculate([], [_head | _tail] = emails) do
    Enum.uniq(emails)
    |> list_map_emails
    |> map_emails
  end

  def calculate(items, [_head | _tail] = emails) do
    total = Enum.reduce(items, 0, fn item, acc -> item.price * item.qty + acc end)
    emails = Enum.uniq(emails)
    qty_emails = length(emails)
    div = div(total, qty_emails)
    rem = rem(total, qty_emails)

    emails_pay_more =
      slice_emails(emails, 0, rem - 1)
      |> list_map_emails(div + 1)

    emails_remaining =
      slice_emails(emails, rem, qty_emails - 1)
      |> list_map_emails(div)

    map_emails(emails_pay_more ++ emails_remaining)
  end

  defp map_emails(list_map_emails) do
    list_map_emails
    |> Enum.reduce(%{}, fn map_item, acc -> Map.merge(map_item, acc) end)
  end

  defp list_map_emails(list, value \\ 0) do
    Enum.map(list, fn email -> %{"#{email}": value} end)
  end

  defp slice_emails(list, lower_bound, upper_bound) do
    case upper_bound < lower_bound do
      true -> []
      _ -> Enum.slice(list, lower_bound..upper_bound)
    end
  end
end
