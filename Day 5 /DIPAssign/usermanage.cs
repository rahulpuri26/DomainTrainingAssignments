using System;
namespace DIPAssign
{
	public class usermanage
	{
        public void PerformBorrowing(IStudent user, string bookTitle)
        {
            user.BorrowBook(bookTitle);
        }

        public void PerformReserving(ITeacher user, string bookTitle)
        {
            user.ReserveBook(bookTitle);
        }

        public void ManageInventory(ILibrarian librarian, string bookTitle, bool isAdding)
        {
            if (isAdding)
                librarian.AddBook(bookTitle);
            else
                librarian.RemoveBook(bookTitle);
        }
    }
}

