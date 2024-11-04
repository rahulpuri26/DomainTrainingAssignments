using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Hosp_Code_First.Models;
using System.Linq;
using System.Threading.Tasks;

namespace Hosp_Code_First.Controllers
{
    public class DoctorsController : Controller
    {
        private readonly HospitalContext _context;

        public DoctorsController(HospitalContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var doctors = await _context.Doctors.Include(d => d.Hospital).ToListAsync();
            return View(doctors);
        }

        public IActionResult Create()
        {
            ViewBag.Hospitals = _context.Hospitals.ToList();
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Doctor doctor)
        {
            if (ModelState.IsValid)
            {
                _context.Add(doctor);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewBag.Hospitals = _context.Hospitals.ToList();
            return View(doctor);
        }

        
    }
}
