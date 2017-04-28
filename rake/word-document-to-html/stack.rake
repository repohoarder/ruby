# this file will hold custom STACK rake tasks
namespace 'stack' do 

	desc "initialize"
	task :init do end

	namespace 'email' do 

		desc "this task creates email template based off of docx"
		task :markup, [:docx,:template,:html] do |task,args|

			# clear file contents
			File.open(args[:html], 'w') {|file| file.truncate(0) }

			# grab start markup from template
			Rake::Task['file:read'].invoke(args[:template] + 'start',args[:html])
			Rake::Task['file:read'].reenable

			# append markup from docx
			Rake::Task['doc:html'].invoke(args[:docx],args[:html])

			# grab end markup from template
			Rake::Task['file:read'].invoke(args[:template] + 'end',args[:html])

		end

		desc "a shortcut for :markup"
		task :doc2email, [:docx,:temp] do |task,args|

			# initialize variables needed
			doc 	= 'docx/stack/emails/' + args[:docx] + '.docx'
			temp 	= 'html/stack/email/templates/' + (args[:temp] || 'default') + '/'
			html 	= 'html/stack/email/generated/' + args[:docx] + '.html'

			# generate email
			Rake::Task['stack:email:markup'].invoke(doc,temp,html)

			puts ">> #{html}"
		end

	end
end