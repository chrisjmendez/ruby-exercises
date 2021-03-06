require 'rubygems'

class Reporting  

  INPUT_FILE = "example.error.log"
  
  def initialize
    read_and_parse
  end
  
  def read_and_parse
    file = File.open(INPUT_FILE, 'r').read

    ip = []
    arr = []
    file.each_line.with_index do |line, idx|      
        arr << line.split(", ") 
        
        @error   = arr[idx][0]
        @ip      = arr[idx][1].tr('client: ', "")
        @request = arr[idx][3].tr('request: ', "")
        @host    = arr[idx][4]
        @referrer = arr[idx][5]            
        #puts %{ #{idx} : #{arr[idx][2]} }
        
        #Inser IP for sorting
        ip << @ip #[@error, @ip, @request, @host, @referrer]
    end
    group_data(ip)
  end
  
  def group_data(arr)
    list = arr.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
    puts list.sort_by {|_key, value| value}.reverse.to_h
  end  
	
	#Spell out the Key / Value pairs
	def publish_data(data)		
		puts %Q{ Method #1 ––––––––––––––––––––––––––\n\n}
		data.each_pair { |key,value| puts %Q{ #{key}: #{value.count} }}
		
		puts %Q{ Method #2 –Sorted–––––––––––––––––––\n\n}
		#Transform data
		count_by_timezone = data.map do |timezone,download|
													[timezone, download.size]
												end.sort_by(&:last).reverse
		
		
		
		#Sort the data
		#count_by_timezone = sort_by_longhand(count_by_timezone)
		count_by_timezone = sort_by_shorthand(count_by_timezone, :last).reverse
		
		#Present Data
		count_by_timezone.map do |pair|
			puts pair.join(": ")
		end
		
		#puts %Q{\n\n #{count_by_timezone} \n\n}		
		
		puts %Q{\n\nMethod #3 ––––––––––––––––––––––––––\n\n}
		keys = data.keys
		puts %Q{ There are #{keys.count} keys }
		puts %Q{ The first key is "#{keys.first}" }
		puts %Q{ "#{keys.first}" has #{data[keys.first].count} downloads  }
	end
	
	def sort_by_longhand(arr)
		arr.sort_by do |pair|
					pair.first
		end
	end
	
	def sort_by_shorthand(arr, symbol)
		arr.sort_by(&symbol)
	end	
end

Reporting.new
