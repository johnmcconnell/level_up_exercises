require "rspec/collection_matchers"

require_relative "../view_parser"
require_relative "../binomial_data_set.rb"

describe BinomialDataSet do
  context "upon recieving data" do
    let(:raw_data) do
      %q([{"date":"2014-03-15","cohort":"B","result":1},
          {"date":"2014-03-20","cohort":"B","result":0},
          {"date":"2014-03-20","cohort":"B","result":0},
          {"date":"2014-03-17","cohort":"B","result":0},
          {"date":"2014-03-21","cohort":"A","result":1},
          {"date":"2014-03-20","cohort":"A","result":0}])
    end

    let(:data) do
      ViewParser.new.parse(raw_data)
    end

    let(:data_set) do
      BinomialDataSet.new(group_field: :id, control_id: "A",
         result_field: :purchased, data: data)
    end

    let(:group_a) do
      data_set.groups["A"]
    end

    let(:group_b) do
      data_set.groups["B"]
    end

    it "provides the total chance success value" do
      expect(data_set.success_percent).to eq(2.0 / 6)
    end

    it "provides the total success count" do
      expect(data_set.success_count).to eq(2)
    end

    it "provides all the groups" do
      expect(data_set).to have(2).groups
    end

    it "provides the success count by group" do
      expect(data_set.groups["A"].count).to eq(2)
      expect(data_set.groups["B"].count).to eq(4)
    end

    it "provides the total chance fail value" do
      expect(data_set.fail_percent).to eq(4.0 / 6)
    end

    it "provides the total fail count" do
      expect(data_set.fail_count).to eq(4)
    end

    it "provides a count of all things" do
      expect(data_set.count).to eq(6)
    end
  end
end
