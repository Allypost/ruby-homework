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

  def to_s
    "#{full_name}, #{id}"
  end
end

class Programmer < Employee
  attr_reader :languages

  def initialize(full_name, id, languages)
    super(full_name, id)
    @languages = languages
  end

  def languages=(value)
    @languages = parse_languages(value)
  end

  def to_s
    "#{super} #{@languages.inspect}"
  end

  private

  def parse_languages(value)
    return value if value.is_a?(Array)
    return value.chomp.split(',').map(&:strip) if value.is_a?(String)

    @languages || []
  end
end

class OfficeManager < Employee
  attr_accessor :office

  def initialize(full_name, id, office)
    super(full_name, id)
    @office = office
  end

  def to_s
    "#{super} (#{@office})"
  end
end

def create_employee(full_name, id, type)
  case type
  when 'e' then
    Employee.new(full_name, id)
  when 'p' then
    print 'Programming languages (comma separated): '
    languages = gets.chomp.split(',').map(&:strip)
    Programmer.new(full_name, id, languages)
  when 'o' then
    print 'Office: '
    office = gets.chomp
    OfficeManager.new(full_name, id, office)
  else
    puts 'Employee type not recognized.'
    nil
  end
end

def add_employee(employees)
  puts '[Add an employee]'
  print 'Full name: '
  full_name = gets.chomp
  print 'ID: '
  id = gets.chomp
  print 'Is the person an [e]mployee, [p]rogrammer or an [o]ffice manager? '
  type = gets.chomp.downcase

  employee = create_employee(full_name, id, type)
  employees << employee unless employee.nil?
end

def edit_property(employee, property_key, property_name)
  print_value = employee.send(property_key)
  print_value = print_value.join(', ') if print_value.is_a?(Array)

  print "#{property_name} [#{print_value}]: "
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
  edit_property(employee, :languages, 'Languages') if employee.is_a?(Programmer)
  edit_property(employee, :office, 'Office') if employee.is_a?(OfficeManager)
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

  sorted_employees(employees, key).each(&method(:puts))
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
