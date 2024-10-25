using System;
using System.Collections.Generic;
using System.IO;
using System.Text.Json;
using System.Xml.Serialization;

namespace PracticeAssign
{
    public class Author
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class Book
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public Author Author { get; set; }
    }

    public class BooksManager
    {
        public void CreateAndSerializeBooks()
        {
            
            List<Author> authors = new List<Author>
            {
                new Author { Id = 1, Name = "Abc" },
                new Author { Id = 2, Name = "Bcd" },
                new Author { Id = 3, Name = "J.K. Rowling"},
                new Author { Id = 4, Name = "Thg"},
                new Author { Id = 5, Name = "JKL"}
            };

            List<Book> books = new List<Book>
            {
                new Book { Id = 1, Title = "48 Laws", Author = authors[0] },
                new Book { Id = 2, Title = "Spare", Author = authors[1] },
                new Book { Id = 3, Title = "Harry Potter", Author = authors[2] },
                new Book { Id = 4, Title = "Atomic Habits", Author = authors[3] },
                new Book { Id = 5, Title = "Ikigai", Author = authors[4] }
            };

           
            string jsonBooksFile = "/Users/monilpuri/Desktop/prc/Books.json";
            string jsonAuthorsFile = "/Users/monilpuri/Desktop/prc/Authors.json";
            string xmlBooksFile = "/Users/monilpuri/Desktop/prc/Books.dat";
            string xmlAuthorsFile = "/Users/monilpuri/Desktop/prc/Authors.dat";

            
            string jsonBooks = JsonSerializer.Serialize(books, new JsonSerializerOptions { WriteIndented = true });
            string jsonAuthors = JsonSerializer.Serialize(authors, new JsonSerializerOptions { WriteIndented = true });

            File.WriteAllText(jsonBooksFile, jsonBooks);
            File.WriteAllText(jsonAuthorsFile, jsonAuthors);

           
            XmlSerializer xmlSerializerBooks = new XmlSerializer(typeof(List<Book>));
            XmlSerializer xmlSerializerAuthors = new XmlSerializer(typeof(List<Author>));

            using (FileStream booksStream = new FileStream(xmlBooksFile, FileMode.Create))
            {
                xmlSerializerBooks.Serialize(booksStream, books);
            }

            using (FileStream authorsStream = new FileStream(xmlAuthorsFile, FileMode.Create))
            {
                xmlSerializerAuthors.Serialize(authorsStream, authors);
            }

           
            Console.WriteLine("Reading JSON Data:");
            string readJsonBooks = File.ReadAllText(jsonBooksFile);
            string readJsonAuthors = File.ReadAllText(jsonAuthorsFile);

            Console.WriteLine("Books (JSON):");
            Console.WriteLine(readJsonBooks);
            Console.WriteLine("Authors (JSON):");
            Console.WriteLine(readJsonAuthors);

            
            Console.WriteLine("\nReading XML Data:");
            using (FileStream booksXmlStream = new FileStream(xmlBooksFile, FileMode.Open))
            {
                List<Book> xmlBooks = (List<Book>)xmlSerializerBooks.Deserialize(booksXmlStream);
                Console.WriteLine("Books (XML):");
                foreach (var book in xmlBooks)
                {
                    Console.WriteLine($"Title: {book.Title}, Author: {book.Author.Name}");
                }
            }

            using (FileStream authorsXmlStream = new FileStream(xmlAuthorsFile, FileMode.Open))
            {
                List<Author> xmlAuthors = (List<Author>)xmlSerializerAuthors.Deserialize(authorsXmlStream);
                Console.WriteLine("\nAuthors (XML):");
                foreach (var author in xmlAuthors)
                {
                    Console.WriteLine($"Id: {author.Id}, Name: {author.Name}");
                }
            }
        }
    }
}
