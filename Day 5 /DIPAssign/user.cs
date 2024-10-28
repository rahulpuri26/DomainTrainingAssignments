using System;
namespace DIPAssign
{
    public class Student : IStudent
    {
        public void BorrowBook(string bookTitle)
        {
            Console.WriteLine($"Student borrowed the book: {bookTitle}");
        }
    }

    public class Teacher : IStudent, ITeacher
    {
        public void BorrowBook(string bookTitle)
        {
            Console.WriteLine($"Teacher borrowed the book: {bookTitle}");
        }

        public void ReserveBook(string bookTitle)
        {
            Console.WriteLine($"Teacher reserved the book: {bookTitle}");
        }
    }

    public class Librarian : ILibrarian
    {
        public void AddBook(string bookTitle)
        {
            Console.WriteLine($"Librarian added the book: {bookTitle} to inventory.");
        }

        public void RemoveBook(string bookTitle)
        {
            Console.WriteLine($"Librarian removed the book: {bookTitle} from inventory.");
        }
    }
}

