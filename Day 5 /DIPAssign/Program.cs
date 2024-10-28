namespace DIPAssign
{
    class Program
    {
        static void Main(string[] args)
        {
            var userManager = new usermanage();

            var student = new Student();
            var teacher = new Teacher();
            var librarian = new Librarian();

           
            userManager.PerformBorrowing(student, "Introduction to Algorithms");

           
            userManager.PerformBorrowing(teacher, "Physics for Scientists");
            userManager.PerformReserving(teacher, "Advanced Physics");

            
            userManager.ManageInventory(librarian, "Data Structures in C#", true);
            userManager.ManageInventory(librarian, "Discrete Mathematics", false);

            Console.ReadLine();
        }
    }
}