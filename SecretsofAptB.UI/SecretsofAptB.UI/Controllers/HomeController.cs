using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using SecretsofAptB.UI.Models;
using SecretsofAPtB.Data;

namespace SecretsofAptB.UI.Controllers
{
    public class HomeController : Controller
    {
        private readonly IBlogRepository _blog;

        public HomeController(IConfiguration nes)
        {
            _blog = new BlogRepository(nes);
        }

        public IActionResult Index( )
        {
            _blog.CreateCategory("stuffness");

            return View();
        }

        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
