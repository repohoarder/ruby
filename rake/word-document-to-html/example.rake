namespace 'example' do

	desc "the init task"
	task :init do 
		puts ">> init"
	end

	desc "runs the first task"
	task :first => :init do 
		puts ">> first"
	end

	desc "runs the second task"
	task :second => :init do 
		puts ">> second"
	end

	desc "runs all (top level) tasks"
	task :all => [:init,:first,:second] do
		puts ">> all"
		
		# running a task within a task
		Rake::Task["example:args"].invoke("x","y")
	end

	desc "a task example passing arguments"
	task :args, [:x,:y,:optional] => :init do |task,args|
		puts ">> args"
		args.each do |key,value|
			puts "#{key}: #{value}"
		end

		puts args[:optional] || 'this was optional'
	end

	desc "example calling a namespaced task"
	task :namespaced do 
		Rake::Task["example:nested:first"].invoke
		puts ">> namespaced"
	end

	desc "example namespaced dependancy"
	task :dependancy => 'nested:first' do 
		puts ">> dependancy"
	end

	namespace 'nested' do 

		desc "nested first task"
		task :first => '^first' do 
			puts ">> nested first"
		end

		namespace 'deeply' do 
			
			desc "nested deeply first task"
			task :first => '^first' do 
				puts ">> nested deeply first"
			end

		end

	end

end