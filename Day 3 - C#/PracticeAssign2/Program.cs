using System;

namespace PracticeAssign2
{
    public class Program
    {
        public static void Main(string[] args)
        {
            

            Customer customer = new Customer
            {
                Name = "Rahul Puri",
                Email = "rahul@example.com",
                PhoneNumber = "9876543210",
                DateOfBirth = DateTime.Parse("1995-07-15")
            };


            Console.WriteLine($"Email Validity :   {CustomerValidator.ValidateEmail(customer.Email)}");
            Console.WriteLine($"Phone Number Validity:   {CustomerValidator.ValidatePhoneNumber(customer.PhoneNumber)}");
            Console.WriteLine($"DOB Validity :   {CustomerValidator.ValidateDateOfBirth("07/15/1995")}");
        }
    }
}

