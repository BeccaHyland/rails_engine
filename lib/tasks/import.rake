require 'csv'
# check the order otherwise they may  not import
namespace :import do
  desc "import all data from CSV files"
  task all: :environment do

    puts 'Please wait while database is cleared of existing records...'
    InvoiceItem.destroy_all
    Item.destroy_all
    Invoice.destroy_all
    Customer.destroy_all
    Transaction.destroy_all
    Merchant.destroy_all
    puts "Database cleared\nCreating Merchants..."

    CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      if row[:id] && row[:name] && row[:created_at] && row[:updated_at]
        Merchant.create!(
          id:          row[:id],
          name:        row[:name],
          created_at:  row[:created_at],
          updated_at:  row[:updated_at]
        )
      end
    end
    puts "Created #{Merchant.count} Merchants\nCreating Customers..."

    CSV.foreach('./data/customers.csv', headers: true, header_converters: :symbol) do |row|
      if row[:id] && row[:first_name] && row[:last_name] && row[:created_at] && row[:updated_at]
        Customer.create!(
          id:          row[:id],
          first_name:  row[:first_name],
          last_name:   row[:last_name],
          created_at:  row[:created_at],
          updated_at:  row[:updated_at],
        )
      end
    end
    puts "Created #{Customer.count} Customers\nCreating Invoices..."


    CSV.foreach('./data/invoices.csv', headers: true, header_converters: :symbol) do |row|
      if row[:id] && row[:customer_id] && row[:merchant_id] && row[:status] && row[:created_at] && row[:updated_at]
        Invoice.create!(
          id:          row[:id],
          customer_id: row[:customer_id],
          merchant_id: row[:merchant_id],
          status:      row[:status],
          created_at:  row[:created_at],
          updated_at:  row[:updated_at]
        )
      end
    end
    puts "Created #{Invoice.count} Invoices\nCreating Items..."

    CSV.foreach('./data/items.csv', headers: true, header_converters: :symbol) do |row|
      if row[:id] && row[:name] && row[:description] && row[:unit_price] && row[:merchant_id] && row[:created_at] && row[:updated_at]
        Item.create!(
          id:          row[:id],
          name:        row[:name],
          description: row[:description],
          unit_price:  row[:unit_price],
          merchant_id: row[:merchant_id],
          created_at:  row[:created_at],
          updated_at:  row[:updated_at]
        )
      end
    end
    puts "Created #{Item.count} Items\nCreating InvoiceItems..."

    CSV.foreach('./data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
      if row[:id] && row[:item_id] && row[:invoice_id] && row[:quantity] && row[:unit_price] && row[:created_at] && row[:updated_at]
        InvoiceItem.create!(
          id:          row[:id],
          item_id:     row[:item_id],
          invoice_id:  row[:invoice_id],
          quantity:    row[:quantity],
          unit_price:  row[:unit_price],
          created_at:  row[:created_at],
          updated_at:  row[:updated_at]
        )
      end
    end
    puts "Created #{InvoiceItem.count} InvoiceItems\nCreating Transactions..."

    CSV.foreach('./data/transactions.csv', headers: true, header_converters: :symbol) do |row|
      if row[:id] && row[:invoice_id] && row[:credit_card_number] && row[:result] && row[:created_at] && row[:updated_at]
        Transaction.create!(
          id:                           row[:id],
          invoice_id:                   row[:invoice_id],
          credit_card_number:           row[:credit_card_number],
          result:                       row[:result],
          created_at:                   row[:created_at],
          updated_at:                   row[:updated_at]
        )
      end
    end
    puts "Created #{Transaction.count} Transactions"
  end
end
