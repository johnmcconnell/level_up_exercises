require "rspec"

require_relative "../viewparser"
require_relative "../dataset.rb"
require_relative "../chisquare.rb"

describe DataSet do
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

    let(:dataset) do
      DataSet.new(group_field: :id, control_id: "A",
         result_field: :purchased, data: data)
    end

    let(:chi_square) do
      ChiSquare.new(dataset: dataset)
    end

    it "should calculate the statistical significance" do
      expect(chi_square.value).to eq(0.375)
      expect(chi_square.significant?).to eq(false)
    end
  end
end