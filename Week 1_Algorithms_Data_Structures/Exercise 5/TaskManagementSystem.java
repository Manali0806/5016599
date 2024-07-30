class Task {
    private String taskId;
    private String taskName;
    private String status;

    // Constructor
    public Task(String taskId, String taskName, String status) {
        this.taskId = taskId;
        this.taskName = taskName;
        this.status = status;
    }

    // Getters
    public String getTaskId() {
        return taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public String getStatus() {
        return status;
    }

    @Override
    public String toString() {
        return "Task [taskId=" + taskId + ", taskName=" + taskName + ", status=" + status + "]";
    }
}

class Node {
    Task task;
    Node next;

    // Constructor
    Node(Task task) {
        this.task = task;
        this.next = null;
    }
}

class TaskLinkedList {
    private Node head;

    // Method to add a task
    public void addTask(Task task) {
        Node newNode = new Node(task);
        if (head == null) {
            head = newNode;
        } else {
            Node current = head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }
    }

    // Method to search for a task by taskId
    public Task searchTask(String taskId) {
        Node current = head;
        while (current != null) {
            if (current.task.getTaskId().equals(taskId)) {
                return current.task;
            }
            current = current.next;
        }
        return null;
    }

    // Method to traverse and print all tasks
    public void traverseTasks() {
        Node current = head;
        while (current != null) {
            System.out.println(current.task);
            current = current.next;
        }
    }

    // Method to delete a task by taskId
    public boolean deleteTask(String taskId) {
        if (head == null) return false;

        if (head.task.getTaskId().equals(taskId)) {
            head = head.next;
            return true;
        }

        Node current = head;
        while (current.next != null && !current.next.task.getTaskId().equals(taskId)) {
            current = current.next;
        }

        if (current.next == null) {
            return false;
        } else {
            current.next = current.next.next;
            return true;
        }
    }
}

public class TaskManagementSystem {

    public static void main(String[] args) {
        TaskLinkedList taskList = new TaskLinkedList();

        Task task1 = new Task("T001", "Design System Architecture", "In Progress");
        Task task2 = new Task("T002", "Develop API", "Not Started");
        Task task3 = new Task("T003", "Write Unit Tests", "In Progress");

        // Add tasks
        taskList.addTask(task1);
        taskList.addTask(task2);
        taskList.addTask(task3);

        // Traverse and display tasks
        System.out.println("Task List:");
        taskList.traverseTasks();

        // Search for a task
        Task searchResult = taskList.searchTask("T002");
        System.out.println("\nSearch Result for T002:");
        System.out.println(searchResult != null ? searchResult : "Task not found");

        // Delete a task
        boolean deleteResult = taskList.deleteTask("T001");
        System.out.println("\nDelete Result for T001:");
        System.out.println(deleteResult ? "Task deleted" : "Task not found");

        // Traverse and display tasks after deletion
        System.out.println("\nTask List after deletion:");
        taskList.traverseTasks();
    }
}
