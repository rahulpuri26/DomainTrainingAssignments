using System;
namespace DIPAssign
{
    public interface IStudent
    {
        void BorrowBook(string bookTitle);
    }

    public interface ITeacher
    {
        void ReserveBook(string bookTitle);
    }

    public interface ILibrarian
    {
        void AddBook(string bookTitle);
        void RemoveBook(string bookTitle);
    }
}

