require "rails_helper"

describe CompaniesHouseCsvParser do
  let(:file_path) { "companies-input.csv" }

  describe ".parse" do
    it "csv file exists" do
      expect { subject.parse(file_path) }.to_not raise_error()
    end

    context "when the file does not exist" do
      let(:file_path) { "random.csv" }

      it "throws an error" do
        expect { subject.parse(file_path) }.to raise_error()
      end
    end
  end

  describe ".output" do
    it "matches the expected company names" do
      rows = CSV.parse(subject.output(file_path, nil), headers: true)
      expect(rows.map{|r| r["company_name"]}[0..1]).to match_array(["FOUNDRY HEALTHCARE LTD", "FOUNDRY HILL LTD"])
    end

    it "matches the expected company number" do
      rows = CSV.parse(subject.output(file_path, nil), headers: true)
      expect(rows.map{|r| r["company_number"]}[0..1]).to match_array(["11350745", "08266458"])
    end

    it "matches the expected address" do
      rows = CSV.parse(subject.output(file_path, nil), headers: true)
      expect(rows.map{|r| r["address"]}[0..1]).to match_array(["SCHOOL HILL HOUSE, LEWES, BN7 2LU", "LANG BENNETTS THE OLD CARRIAGE WORKS, TRURO, TR1 1DG"])
    end

    it "matches the expected previous name" do
      rows = CSV.parse(subject.output(file_path, nil), headers: true)
      expect(rows.map{|r| r["previous_name"]}[12]).to eq("FOUNDRY WORK SHOP MEET EAT STAY LIMITED")
    end
  end
end
