require 'i18n_tasks'
require 'i18n_extraction'
# require 'shellwords'

namespace :alfabook_i18n do

# RAILS_ENV=development bundle exec rake alfabook_i18n:to_csv['/path/to/the/file.yml']
	desc "Convert translations to csv file"
	task :to_csv, [:input_file] => :environment do |t, args|
		Hash.send :include, I18nTasks::HashExtensions
		en_file = "config/locales/generated/en.yml"
		base_filename = args[:input_file].presence || en_file
		en_strings = YAML.safe_load(File.read(en_file)).flatten_keys
		current_strings = YAML.safe_load(File.read(base_filename)).flatten_keys
		puts "Keys found: #{current_strings.size}"

		out_file = "#{base_filename}.csv"

		CSV.open(out_file, "wb") do |csv|
			csv << %w{Key EN Translated}
			current_strings.each do |key, translated|
				en_string = en_strings[key] || ''
				csv << [key, en_string,  translated]
			end
		end
		puts "Done! Result file written on #{out_file}"
	end

# Hint: the first column must be the flatten key (it.course.label), while the translated label should be in the column
# passed as argument:
# RAILS_ENV=development bundle exec rake alfabook_i18n:from_csv['/path/to/the/file.csv', 1]
# RAILS_ENV=development bundle exec rake alfabook_i18n:from_csv['/path/to/the/file.csv', 1, true] for getting only not empty values
	desc "Convert translations from csv to yml"
	task :from_csv, [:input_file, :col_idx, :diff_only] => :environment do |t, args|
		require 'ya2yaml'
		Hash.send :include, I18nTasks::HashExtensions
		base_filename = args[:input_file]
		col_idx = args[:col_idx].presence.try(:to_i) || 1
		diff_only = args[:diff_only] == 'true'
		puts "Reading file #{base_filename}, column #{col_idx} ..."

		translated_strings = {}
		last_valid_key = nil
		CSV.foreach(base_filename, encoding: "UTF-8", skip_blanks: true, headers: true) do |row|

			key = row[0].strip rescue ''
			value = row[col_idx]

			unless value.nil?
				last_valid_key = key if key_valid?(key)
				value.strip!
			else
				if row.to_a.join('').blank?
					value = '\n' #empty row
				else
					if key_valid?(key)
						value = ''
						last_valid_key = key
					else
						value = key #value is in the first column
					end
				end
			end

			begin
				next if last_valid_key.blank?
				valid_value = translated_strings[last_valid_key] || ''
				valid_value += value
				next if diff_only and valid_value.blank?
				translated_strings[last_valid_key] = valid_value
			rescue => e
				puts "Errors #{e.message} for #{row}"
				puts "valid_value: #{valid_value} - value: #{value}"
			end
		end

		out_file = "#{base_filename}.yml"
		File.open(out_file, "w") { |f| f.write translated_strings.expand_keys.ya2yaml(:syck_compatible => true) }
		puts "Done! Result file written on #{out_file}"
	end


	def key_valid?(key)
		key.present? and (key.index('en.') == 0 or key.index('it.') == 0)
	end

end
