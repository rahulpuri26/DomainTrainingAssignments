using TransportM;

namespace PracticeAssign3
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var manager = new TransportManager();

            
            manager.AddSchedule(new TransportSchedule { TransportType = "Bus", Route = "CityA to CityB", DepartureTime = DateTime.Parse("2024-10-25 08:00"), ArrivalTime = DateTime.Parse("2024-10-25 12:00"), Price = 20.50m, SeatsAvailable = 25 });
            manager.AddSchedule(new TransportSchedule { TransportType = "Flight", Route = "CityA to CityC", DepartureTime = DateTime.Parse("2024-10-25 09:00"), ArrivalTime = DateTime.Parse("2024-10-25 11:00"), Price = 150.00m, SeatsAvailable = 10 });
            manager.AddSchedule(new TransportSchedule { TransportType = "Bus", Route = "CityB to CityD", DepartureTime = DateTime.Parse("2024-10-25 10:00"), ArrivalTime = DateTime.Parse("2024-10-25 14:00"), Price = 25.00m, SeatsAvailable = 15 });
            manager.AddSchedule(new TransportSchedule { TransportType = "Flight", Route = "CityA to CityD", DepartureTime = DateTime.Parse("2024-10-25 07:30"), ArrivalTime = DateTime.Parse("2024-10-25 09:30"), Price = 200.00m, SeatsAvailable = 5 });
            manager.AddSchedule(new TransportSchedule { TransportType = "Bus", Route = "CityC to CityE", DepartureTime = DateTime.Parse("2024-10-25 06:00"), ArrivalTime = DateTime.Parse("2024-10-25 10:00"), Price = 15.00m, SeatsAvailable = 30 });

       
            var flights = manager.SearchSchedules(transportType: "Flight");
            Console.WriteLine("Flights:");
            foreach (var schedule in flights)
            {
                Console.WriteLine($"{schedule.Route} - {schedule.DepartureTime} - ${schedule.Price}");
            }

          
            var groupedByType = manager.GroupByTransportType();
            Console.WriteLine("\nGrouped by Transport Type:");
            foreach (var group in groupedByType)
            {
                Console.WriteLine($"{group.Key}:");
                foreach (var schedule in group)
                {
                    Console.WriteLine($"  {schedule.Route} - {schedule.DepartureTime} - ${schedule.Price}");
                }
            }

           
            var orderedByPrice = manager.OrderSchedules("price");
            Console.WriteLine("\nOrdered by Price:");
            foreach (var schedule in orderedByPrice)
            {
                Console.WriteLine($"{schedule.Route} - ${schedule.Price}");
            }

           
            var filteredSchedules = manager.FilterSchedules(minSeats: 10, startTime: DateTime.Parse("2024-10-25 08:00"));
            Console.WriteLine("\nFiltered Schedules (at least 10 seats, departure after 8:00 AM):");
            foreach (var schedule in filteredSchedules)
            {
                Console.WriteLine($"{schedule.Route} - {schedule.DepartureTime} - Seats: {schedule.SeatsAvailable}");
            }

           
            var (totalSeats, avgPrice) = manager.GetAggregateData();
            Console.WriteLine($"\nTotal Seats: {totalSeats}, Average Price: ${avgPrice:F2}");

          
            var routeDepartures = manager.GetRouteAndDepartureTimes();
            Console.WriteLine("\nRoutes and Departure Times:");
            foreach (var item in routeDepartures)
            {
                Console.WriteLine($"Route: {item.Route}, Departure Time: {item.DepartureTime}");
            }
        }


    }
}