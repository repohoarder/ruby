# define the rake namespace (optionally)
namespace :directory do

	# show the rake description
	desc "Read and manipulate directories"

	# define the task
	task :read, [:path] do |task, args|

		# read the directory
		FileList["#{args[:path]}*"].gsub(args[:path],'').each do |file|
			# add trailing / for directories
			puts (File.file?(args[:path] + file))? file: file + "/"
		end

	end

	task :make, [:dir,:test] do |task,args| 

		puts "#{args}"

	end

end