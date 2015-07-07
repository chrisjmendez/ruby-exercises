def func1
  i = 0
  while i <= 5
    puts "func1 at: #{Time.now}"
    sleep(2)
    i = i + 1
  end
end
def func2
  i = 0
  while i <= 5
    puts "func2 at: #{Time.now}"
    sleep(1)
    i = i + 1
  end
end

puts "Start at: #{Time.now}"
t1 = Thread.new{func1()}
t2 = Thread.new{func2()}
t1.join
t2.join
puts "End at: #{Time.now}"