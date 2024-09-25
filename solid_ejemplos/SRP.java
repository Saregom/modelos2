package solid_ejemplos;

// Clase que representa solo la información del libro (una sola responsabilidad)
class Book {
    private String title;
    private String author;

    public Book(String title, String author) {
        this.title = title;
        this.author = author;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    @Override
    public String toString() {
        return "Título: " + title + ", Autor: " + author;
    }
}

// Clase que se encarga de guardar el libro (otra responsabilidad)
class BookPersistence {
    public void saveToFile(Book book, String filename) {
        System.out.println("Guardando el libro '" + book.getTitle() + "' en el archivo: " + filename);
    }

    public void saveToDatabase(Book book) {
        System.out.println("Guardando el libro '" + book.getTitle() + "' en la base de datos.");
    }
}

// Main
public class SRP {
    public static void main(String[] args) {
        System.out.println("Single Responsibility Principle");

        Book book = new Book("El Principito", "Antoine de Saint-Exupéry");
        BookPersistence persistence = new BookPersistence();

        // Guardamos en archivo
        persistence.saveToFile(book, "libro.txt");

        // Guardamos en base de datos
        persistence.saveToDatabase(book);

        // Mostramos el libro guardado
        System.out.println("Libro guardado: " + book);
    }
}



