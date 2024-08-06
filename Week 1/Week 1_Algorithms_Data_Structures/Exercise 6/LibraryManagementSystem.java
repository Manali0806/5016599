import java.util.Arrays;
class Book {
    private String bookId;
    private String title;
    private String author;

    // Constructor
    public Book(String bookId, String title, String author) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
    }

    // Getters
    public String getBookId() {
        return bookId;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    @Override
    public String toString() {
        return "Book [bookId=" + bookId + ", title=" + title + ", author=" + author + "]";
    }
}

class Library {
    private Book[] books;
    private int count;

    // Constructor to initialize the array
    public Library(int capacity) {
        books = new Book[capacity];
        count = 0;
    }

    // Method to add a book
    public void addBook(Book book) {
        if (count < books.length) {
            books[count] = book;
            count++;
        } else {
            System.out.println("Library is full. Cannot add more books.");
        }
    }

    // Method to implement linear search to find books by title
    public Book linearSearchByTitle(String title) {
        for (int i = 0; i < count; i++) {
            if (books[i].getTitle().equalsIgnoreCase(title)) {
                return books[i];
            }
        }
        return null;
    }

    // Method to implement binary search to find books by title (assuming the list is sorted)
    public Book binarySearchByTitle(String title) {
        Arrays.sort(books, 0, count, (a, b) -> a.getTitle().compareToIgnoreCase(b.getTitle()));
        int left = 0;
        int right = count - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int comparison = books[mid].getTitle().compareToIgnoreCase(title);

            if (comparison == 0) {
                return books[mid];
            } else if (comparison < 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return null;
    }
}

public class LibraryManagementSystem {

    public static void main(String[] args) {
        Library library = new Library(10);

        Book book1 = new Book("B001", "Effective Java", "Joshua Bloch");
        Book book2 = new Book("B002", "Clean Code", "Robert C. Martin");
        Book book3 = new Book("B003", "Design Patterns", "Erich Gamma");
        Book book4 = new Book("B004", "The Pragmatic Programmer", "Andrew Hunt");
        Book book5 = new Book("B005", "Introduction to Algorithms", "Thomas H. Cormen");

        // Add books to the library
        library.addBook(book1);
        library.addBook(book2);
        library.addBook(book3);
        library.addBook(book4);
        library.addBook(book5);

        // Linear search for a book by title
        String searchTitle = "Clean Code";
        Book linearSearchResult = library.linearSearchByTitle(searchTitle);
        System.out.println("Linear Search Result for '" + searchTitle + "':");
        System.out.println(linearSearchResult != null ? linearSearchResult : "Book not found");

        // Binary search for a book by title
        Book binarySearchResult = library.binarySearchByTitle(searchTitle);
        System.out.println("\nBinary Search Result for '" + searchTitle + "':");
        System.out.println(binarySearchResult != null ? binarySearchResult : "Book not found");
    }
}
