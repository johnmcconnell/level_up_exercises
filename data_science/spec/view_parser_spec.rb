require "rspec"
require "date"

require_relative "../page_view"
require_relative "../view_parser"

describe ViewParser do
  context "upon parsing json" do

    let(:parser) { ViewParser.new }

    let(:purchase_date) { Date.parse("2014-05-19") }

    let(:no_purchase_date) { Date.parse("2013-06-10") }

    let(:purchase_view) do
      json = '[{"date":"2014-05-19","cohort":"A","result":1}]'
      parser.parse(json)[0]
    end

    let(:no_purchase_view) do
      json = '[{"date":"2013-06-10","cohort":"B","result":0}]'
      parser.parse(json)[0]
    end

    it "should parse the purchase view" do
      expect(purchase_view.id).to eq("A")
      expect(purchase_view.date).to eq(purchase_date)
      expect(purchase_view.purchased).to eq(true)
    end

    it "should parse the no purchase view" do
      expect(no_purchase_view.id).to eq("B")
      expect(no_purchase_view.date).to eq(no_purchase_date)
      expect(no_purchase_view.purchased).to eq(false)
    end
  end
end
