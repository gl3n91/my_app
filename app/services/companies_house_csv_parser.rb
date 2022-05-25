require 'csv'

class CompaniesHouseCsvParser
  def parse file_path
    file_string = File.read(file_path)
    CSV.parse(file_string, headers: true)
  end

  def output input_file, output_file
    rows = parse(input_file)
    CSV.generate do |csv|
      csv << %w[company_name company_number address previous_name]
      rows.map {|r| [r.fetch("CompanyName"), r.fetch(" CompanyNumber"), fetch_address(r), r.fetch(" PreviousName_1.CompanyName")]}.each do |row|
        csv << row
      end
    end
  end

  def fetch_address row
    [row.fetch("RegAddress.AddressLine1"), row.fetch("RegAddress.PostTown"), row.fetch("RegAddress.PostCode")].join(", ")
  end
end
