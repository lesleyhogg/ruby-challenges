# This is the Menu module.
module Menu
  def menu
    "
    Welcome to the Todo program.
    This menu will help you use the Task List System.
    1. Add a task
    2. Show current list of tasks
    3. Update a task
    4. Delete a task
    5. Write to a file
    6. Import tasks from a file
    7. Change a task status to complete or incomplete
    8. Quit

    "
  end
  def show
    menu
  end
end

#The is the user input Promptable module.
module Promptable
  def prompt(message = "What would you like to do?", symbol = ":> ")
    print message
    print symbol
    gets.chomp
  end
end

# This is the List class. It creates and manages at the List level.
class List
  attr_reader :all_tasks
  def initialize
    @all_tasks = []
  end
  def add_task(task)
    all_tasks << task
  end
  def show
    all_tasks.map.with_index { |list_item, num| "#{num.next}): #{list_item}" }
  end
  def update(task_number, task)
    all_tasks[task_number - 1] = task
  end
  def delete(task_number)
    all_tasks.delete_at(task_number - 1)
  end
  def write_to_file(filename)
    machinified = @all_tasks.map(&:to_machine).join("\n")
    IO.write(filename, machinified)
  end
  def read_from_file(filename)
    IO.readlines(filename).each do |line|
      status, *description = line.split(":")
      status = status.include?("X")
      add_task(Task.new(description.join(":").strip, status))
    end
  end
  def toggle(task_number)
    all_tasks[task_number - 1].toggle_status
  end
end

# This is the Task class. It creates and manages at the task level.
class Task
  attr_reader :description
  attr_accessor :status
  def initialize(description, status = false)
    @description = description
    @status = status
  end
  def to_s
    "#{represent_status}: #{description}"
  end
  def completed?
    status
  end
  def to_machine
    "#{represent_status}: #{description}"
  end
  def toggle_status
    @status = !completed?
  end
  private
  def represent_status
    completed? ? "[X]" : "[ ]"
  end

end

# List and Task building action
if "todo.rb" == $PROGRAM_NAME
  include Menu
  include Promptable
  my_list = List.new
  puts "Please choose from the following list:"
    until ['8'].include?(user_input = prompt(show).downcase)
      case user_input
      when '1' # Add
          my_list.add_task(Task.new(prompt("What is the task you wish to accomplish?")))
          prompt("Task added. Press enter to continue.", "")
        when '2' # Show
          puts "Tasks presently on the list:"
          if my_list == []
            puts "No tasks to display."
          else
            puts my_list.show
          end
        when '3' # Update
          puts "Tasks presently on the list:"
          puts my_list.show
          my_list.update(prompt("Which task do you wish to update? Provide the number.").to_i,
          Task.new(prompt("What is the new task description?")))
        when '4' # Delete
          puts "Tasks presently on the list:"
          puts my_list.show
          my_list.delete(prompt("Which task do you wish to delete? Provide the number.").to_i)
        when '5' # Write
          my_list.write_to_file(prompt("What is the filename to write to? (e.g. list.txt)"))
        when '6' # Import
          begin
            my_list.read_from_file(prompt("What is the filename you wish to use? (e.g. list.txt)"))
          rescue Errno::ENOENT
            puts "File name not found."
          end
        when '7' # Change status
          puts "Tasks presently on the list:"
          puts my_list.show
          my_list.toggle(prompt("Which task do you wish to change the status?").to_i)
        else
          puts "Invalid entry."
      end
    end
    puts "Outro - Thanks for using the menu system!"
end
#Whew!
