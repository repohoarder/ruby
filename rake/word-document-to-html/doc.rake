require 'docx'

namespace 'doc' do

	desc "read and print a docx file"
	task :read, [:file] do |task,args|		
		lines = Docx::Document.open(args[:file])
		lines.each_paragraph do |p|
		  puts p
		end
	end

	desc "convert docx file to html markup"
	task :html, [:docx,:html] do |task,args|

		# initialize variables
		markup 	= ''

		# grab docx
		lines 	= Docx::Document.open(args[:docx])
		
		#iterate docx file
		lines.each_paragraph do |p|

			# format line as needed
			markup 	= p.to_html
				.gsub(/\u2013/,"-")			# replace docx -
				.gsub(/\u2014/,"&mdash;") 	# replace docx --
				.gsub(/’/,"'")				# replace docx ''
				.gsub(/Â/,"</p><p>") 		# format paragraph (this only happens on rare cases)
				.gsub(/“/,'"') 				# replace docx opening "
				.gsub(/”/,'"') 				# replace docx closing "
				.gsub(/…/,'...') 			# replace docx …
				.gsub(/<p><\/p>/,'') 		# remove empty paragraph tags
				.gsub(/font-size:pt;/,"") 	# now im just getting rediculous
				.gsub(/font-size:10pt;/,"") # now im just getting rediculous
				.gsub(/font-size:12pt;/,"") # now im just getting rediculous
				.gsub(/font-size:9pt;/,"") 	# now im just getting rediculous
				.gsub(/ style=""/,"") 		# remove empty styles
				.gsub(/<span style="text-decoration:underline;">/,'<a href="#link">')	# generates links based on underlines (NOT SAFE)
				.gsub(/<\/span>/,"</a>")	# generates closing a tag based off of closing span tag (NOT SAFE)
				.sub(/•/,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#46;") 		# this only applys to the first one
				.gsub(/•/,"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#46;")	# attempts to format unordered lists
				
			# append markup to html file, if applicable
			if (args[:html] || false)
				Rake::Task['file:append'].invoke(args[:html],markup)
				Rake::Task['file:append'].reenable
			else
				puts markup
			end

		end

	end

end