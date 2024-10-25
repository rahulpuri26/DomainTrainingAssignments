using System;
using System.Text.RegularExpressions;

namespace PracticeAssign2
{
    public class Customer
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public DateTime DateOfBirth { get; set; }
    }

    public static class CustomerValidator
    {

        static readonly string phonePattern = @"^[6-9]\d{9}$";


        static string emailPattern = @"^[^@\s]+@[^@\s]+\.(com|net|org|gov|in)$";


        static string dobPattern = @"^(0[1-9]|1[012])[-/.](0[1-9]|[12][0-9]|3[01])[-/.](19|20)\d{2}$";


        public static bool ValidatePhoneNumber(string phoneNumber)
        {
            return Regex.IsMatch(phoneNumber, phonePattern);
        }

        public static bool ValidateEmail(string email)
        {
            return Regex.IsMatch(email, emailPattern);
        }

        public static bool ValidateDateOfBirth(string dob)
        {

            if (!Regex.IsMatch(dob, dobPattern))
            {
                return false;
            }


            DateTime parsedDate;
            bool isValidDate = DateTime.TryParseExact(dob, "MM/dd/yyyy", null, System.Globalization.DateTimeStyles.None, out parsedDate) ||
                               DateTime.TryParseExact(dob, "MM-dd-yyyy", null, System.Globalization.DateTimeStyles.None, out parsedDate);
            return isValidDate && parsedDate < DateTime.Today;
        }
    }
}
