#!/usr/bin/env ruby

# David Selassie
# April 28, 2011
# backupfile.rb

# Extends Ruby's File class so that opening a file for writing with an existing file name causes that existing file to be backed up.

class BackupFile < File
	def self.open(fd, mode_string='r', *opt)
		if (mode_string.include?('w') or mode_string.include?('a')) and File.exists?(fd) then
			fd_dir = File.dirname(fd)
			fd_base = File.basename(fd)

			index = 0
			begin
				index += 1
				fd_backup = File.join(fd_dir, "##{fd_base}.#{index}#")
			end while File.exists?(fd_backup)

			File.rename(fd, fd_backup)

			STDERR.puts("Backed up #{fd} to #{fd_backup}")
		end

		super
	end
end

