using System;
using System.Numerics;

namespace Hosp_Code_First.Models
{
    public class Hospital
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public ICollection<Doctor> Doctors { get; set; }
    }

}

