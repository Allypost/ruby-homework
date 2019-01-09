class Employee
  attr_accessor :full_name
  attr_accessor :id

  def initialize(full_name, id)
    @full_name = full_name
    @id = id
  end

  def forename
    @full_name.split(' ', 2).first
  end

  def surname
    @full_name.split(' ', 2).last
  end
end

def add_employee(employees)
  puts '[Add an employee]'
  print 'Full name: '
  full_name = gets.chomp
  print 'ID: '
  id = gets.chomp

  employee = Employee.new(full_name, id)

  employees << employee
end

def edit_property(employee, property_key, property_name)
  old_value = employee.send(property_key)
  print "#{property_name} [#{old_value}]: "
  new_value = gets.chomp

  employee.send("#{property_key}=", new_value) unless new_value.strip.empty?
end

def edit_employee(employees)
  puts '[Edit an employee]'

  print 'Enter employee id: '
  old_id = gets.chomp

  employee = employees.find { |e| e.id == old_id }

  return puts "Employee with that ID doesn't exist" unless employee

  puts 'Employee found. Leave field blank to keep old value.'
  edit_property(employee, :full_name, 'Full name')
  edit_property(employee, :id, 'ID')
end

def get_sort_key
  print 'Sort by [f]irst name or [l]ast name? '
  key = gets.chomp.downcase

  case key
  when 'f' then
    :forename
  when 'l' then
    :surname
  else
    nil
  end
end

def view_employees(employees)
  key = get_sort_key

  while key.nil?
    puts 'Unknown field. Please try again.'
    key = get_sort_key
  end

  sorted_employees(employees, key).each do |employee|
    puts "#{employee.full_name}, #{employee.id}"
  end
end

def sorted_employees(employees, key)
  employees.sort_by do |employee|
    employee.send(key)
  end
end

def quit
  puts 'Goodbye!'
  exit
end

def print_help
  puts '[HELP]'
  puts 'Enter one of the following:'
  puts 'a - to add a new employee'
  puts 'e - to edit an existing employee'
  puts 'v - to view existing employees'
  puts 'q - to quit the program'
end

def get_action
  gets.downcase[0]
end

puts 'Employee-o-matic 4000'

employees = []

loop do
  print 'What do you want to do? '
  action = get_action

  case action
  when 'a' then
    add_employee(employees)
  when 'e' then
    edit_employee(employees)
  when 'v' then
    view_employees(employees)
  when 'q' then
    quit
  else
    print_help
  end
end
