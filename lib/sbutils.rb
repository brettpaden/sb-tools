#--------------------------------------------------------------------------------
# SBUTils class for shared sandbox functors.
#
require 'fileutils'  # needed for mkdir_p

class SBUtils
    # class instance variable; should be the same across all instances 
	@@user_root = '/u'
    # fetcht the class instance variable
    def user_root
	    @@user_root
	end

    #--------------------------------------------------------------------------------
	def parse_stdin(prompt, default, skip)
    #--------------------------------------------------------------------------------
    # simple util to read stdin interactively then clean it up.  Accepts three arguments
    # a prompt string, a default value and a skip value.  
	#
		if skip != nil then return skip end
		if default.kind_of? String then                                # bam ... gott check if its a string
			if default.length > 0 then prompt += " (#{default})" end   # of .length will bust its nut all over you
		end
		print "#{prompt}: "
		STDOUT.flush
		value = STDIN.gets
		value.chomp!
		if value == '' then value = default end                        # srs? ifthenend is gayness
		if value == nil || value == '' then return parse_stdin('   try again, asshole', default) end
		return value
	end

    #--------------------------------------------------------------------------------
	def apache_conf_file(user=ENV['USER'], project=ENV['PROJECT'])
    #--------------------------------------------------------------------------------
	# As the name implies, returns the path of the apache config file.  Also generates
	# directory structure for housing it automagically
		output_root = user_root + '/' + user + '/apache';
		FileUtils.mkdir_p output_root
		output_file_location = output_root + '/' + project + '.conf'
		return output_file_location
	end


    #--------------------------------------------------------------------------------
	def apache_conf_files_for_project(user=ENV['USER'], project=ENV['PROJECT'])
    #--------------------------------------------------------------------------------
	# returns a list of all apache conf files associated with this project
		output_root = user_root + '/' + user + '/apache'
		return Dir[output_root + '/' + project + '_*.conf']
	end

    #--------------------------------------------------------------------------------
	def apache_pid_file(user=ENV['USER'], project=ENV['PROJECT'])
    #--------------------------------------------------------------------------------
	# As the name implies, returns the path of the apache pid file.  Also generates
	# directory structure for housing it automagically
		output_root = user_root + '/' + user + '/apache/pids'
		FileUtils.mkdir_p output_root
		output_file_location = output_root + '/' + project + '.pid'
		return output_file_location
	end

    #--------------------------------------------------------------------------------
	def apache_pid_files_for_project(user=ENV['USER'], project=ENV['PROJECT'])
    #--------------------------------------------------------------------------------
	# returns a list of all pid files associated with apaches running under this project
		output_root = user_root + '/' + user + '/apache/pids'
		return Dir[output_root + '/' + project + '-*.pid']
	end

    #--------------------------------------------------------------------------------
	def apache_log_dir(user=ENV['USER'])
    #--------------------------------------------------------------------------------
	# As the name implies, returns the path of the apache log files.  Also generates
	# directory if it does not exist
		output_root = user_root + '/' + user + '/apache/logs'
		FileUtils.mkdir_p output_root
		return output_root
	end


end
