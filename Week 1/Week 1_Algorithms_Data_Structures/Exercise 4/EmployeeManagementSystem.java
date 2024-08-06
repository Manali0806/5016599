class Employee {
    private String employeeId;
    private String name;
    private String position;
    private double salary;

    // Constructor
    public Employee(String employeeId, String name, String position, double salary) {
        this.employeeId = employeeId;
        this.name = name;
        this.position = position;
        this.salary = salary;
    }

    // Getters and Setters
    public String getEmployeeId() {
        return employeeId;
    }

    public String getName() {
        return name;
    }

    public String getPosition() {
        return position;
    }

    public double getSalary() {
        return salary;
    }

    @Override
    public String toString() {
        return "Employee [employeeId=" + employeeId + ", name=" + name + ", position=" + position + ", salary=" + salary + "]";
    }
}

class EmployeeManagement {
    private Employee[] employees;
    private int count;

    // Constructor to initialize the array
    public EmployeeManagement(int capacity) {
        employees = new Employee[capacity];
        count = 0;
    }

    // Method to add an employee
    public boolean addEmployee(Employee employee) {
        if (count < employees.length) {
            employees[count] = employee;
            count++;
            return true;
        } else {
            System.out.println("Employee array is full. Cannot add more employees.");
            return false;
        }
    }

    // Method to search for an employee by employeeId
    public Employee searchEmployee(String employeeId) {
        for (int i = 0; i < count; i++) {
            if (employees[i].getEmployeeId().equals(employeeId)) {
                return employees[i];
            }
        }
        return null;
    }

    // Method to traverse and print all employees
    public void traverseEmployees() {
        for (int i = 0; i < count; i++) {
            System.out.println(employees[i]);
        }
    }

    // Method to delete an employee by employeeId
    public boolean deleteEmployee(String employeeId) {
        for (int i = 0; i < count; i++) {
            if (employees[i].getEmployeeId().equals(employeeId)) {
                employees[i] = employees[count - 1];
                employees[count - 1] = null;
                count--;
                return true;
            }
        }
        return false;
    }
}

public class EmployeeManagementSystem {

    public static void main(String[] args) {
        EmployeeManagement empManager = new EmployeeManagement(10);

        Employee emp1 = new Employee("E001", "Alice", "Manager", 75000);
        Employee emp2 = new Employee("E002", "Bob", "Developer", 60000);
        Employee emp3 = new Employee("E003", "Charlie", "Designer", 55000);

        // Add employees
        empManager.addEmployee(emp1);
        empManager.addEmployee(emp2);
        empManager.addEmployee(emp3);

        // Traverse and display employees
        System.out.println("Employee List:");
        empManager.traverseEmployees();

        // Search for an employee
        Employee searchResult = empManager.searchEmployee("E002");
        System.out.println("\nSearch Result for E002:");
        System.out.println(searchResult != null ? searchResult : "Employee not found");

        // Delete an employee
        boolean deleteResult = empManager.deleteEmployee("E001");
        System.out.println("\nDelete Result for E001:");
        System.out.println(deleteResult ? "Employee deleted" : "Employee not found");

        // Traverse and display employees after deletion
        System.out.println("\nEmployee List after deletion:");
        empManager.traverseEmployees();
    }
}
