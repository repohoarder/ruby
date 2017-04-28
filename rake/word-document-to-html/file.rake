require 'csv'

namespace "file" do

	desc "read a file"
	task :read, [:file,:append] do |task,args| 

		# init var
		markup 	= ''

		File.open(args[:file]).each do |line|
			markup += line
		end

		if (args[:append] || false)
			Rake::Task['file:append'].invoke(args[:append],markup)
			Rake::Task['file:append'].reenable
		else 
			puts markup
		end

	end

	desc "write a new line to a file"
	task :write, [:file,:data] do |task,args|

		# write to file
		File.open(args[:file],"w+") do |line|
			line.puts "\r#{args[:data]}"
		end

		# read the file
		#Rake::Task["file:read"].invoke(args[:file])

	end

	desc "append a new line to a file"
	task :append, [:file,:data] do |task,args|

		# write to file
		File.open(args[:file],"a") do |line|
			line.puts "#{args[:data]}\r"
		end

		# read the file
		#Rake::Task["file:read"].invoke(args[:file])

	end

	namespace 'csv' do 

		desc "read a csv"
		task :read, [:file] => '^read' do |task,args| end

		desc "write to a csv"
		task :write, [:file,:data] do |task,args|


			# open CSV to write
			CSV.open(args[:file], "w+") do |csv|

				# add data to CSV
				csv << args[:data].split(':').map

			end

			# read the csv
			#Rake::Task['file:read'].invoke(args[:file])

		end

		desc "append to a csv"
		task :append, [:file,:data] do |task,args|


			# open CSV to write
			CSV.open(args[:file], "a") do |csv|

				# add data to CSV
				csv << args[:data].split(':').map
				
			end

			# read the csv
			#Rake::Task['file:read'].invoke(args[:file])

		end

	end

end