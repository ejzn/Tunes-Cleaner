#!/usr/bin/env ruby
require 'find'
require 'fileutils'

# This script will attempt to clean up your ITunes library
# Proceed with caution, it will delete some of your files :)

def Cleaner(start_dir=".")
	# Array that will hold the unique files
	files = Array.new
	dups = Array.new
	
	# get a full file list
	Dir.new(start_dir).each do |file|
		unless ['.','..'].include? file
			files.push(file)
		end
	end

	# Find the duplicate matches
	Matcher(files, dups)
	

	if dups.length == 0
		print "No dups found nothing to delete. "
	else
		print "The following matches where found: \n"
		puts(dups)
		print "\n"
	end

	Delete(dups)

end

# This function uses the matching rules to find duplicates
# The duplicates are then put into the dup array to be deleted

def Matcher(files, dups)
	for file in files
		reg = /\d*\s*[\w+\s*]+\s+\d+.mp3/
		if reg.match(file)
			
			# Now that we have a match let's see if a base file exists
			#first remove the extension
			base = File.basename(file,".mp3");
			reg_base = /\s*[a-zA-Z]+/
			
			if (base_match = reg_base.match(base))
				
				# We found a base file, so we can remove the other one..
				base_match = base_match[0].strip
				print "Base file: "
				dups.push(file)
			
			end
				
		end
	end
end

#Delete all the dupes from the file system
def Delete(dups)
	for file in dups
		File.delete(file);
	end
end

Cleaner()
