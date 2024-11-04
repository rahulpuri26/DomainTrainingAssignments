using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Hosp_Code_First.Models;
using System.Linq;
using System.Threading.Tasks;

namespace Hosp_Code_First.Controllers
{
    public class HospitalsController : Controller
    {
        private readonly HospitalContext _context;

        public HospitalsController(HospitalContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            return View(await _context.Hospitals.ToListAsync());
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Hospital hospital)
        {
            if (ModelState.IsValid)
            {
                _context.Add(hospital);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(hospital);
        }

        
    }
}
