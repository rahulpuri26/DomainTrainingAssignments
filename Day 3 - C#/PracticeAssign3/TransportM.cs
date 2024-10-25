
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PracticeAssign3;

namespace TransportM
{
    internal class TransportManager
    {
        private List<TransportSchedule> schedules;

        public TransportManager()
        {
            schedules = new List<TransportSchedule>();
        }

        public void AddSchedule(TransportSchedule schedule)
        {
            schedules.Add(schedule);
        }


        public IEnumerable<TransportSchedule> SearchSchedules(string transportType = null, string route = null, DateTime? time = null)
        {
            return schedules.Where(s =>
                (transportType == null || s.TransportType.Equals(transportType, StringComparison.OrdinalIgnoreCase)) &&
                (route == null || s.Route.Equals(route, StringComparison.OrdinalIgnoreCase)) &&
                (time == null || s.DepartureTime == time || s.ArrivalTime == time)
            );
        }

        public IEnumerable<IGrouping<string, TransportSchedule>> GroupByTransportType()
        {
            return schedules.GroupBy(s => s.TransportType);
        }

        public IEnumerable<TransportSchedule> OrderSchedules(string orderBy)
        {
            return orderBy.ToLower() switch
            {
                "departuretime" => schedules.OrderBy(s => s.DepartureTime),
                "price" => schedules.OrderBy(s => s.Price),
                "seatsavailable" => schedules.OrderBy(s => s.SeatsAvailable),
                _ => schedules
            };
        }

        public IEnumerable<TransportSchedule> FilterSchedules(int? minSeats = null, DateTime? startTime = null, DateTime? endTime = null)
        {
            return schedules.Where(s =>
                (minSeats == null || s.SeatsAvailable >= minSeats) &&
                (startTime == null || s.DepartureTime >= startTime) &&
                (endTime == null || s.ArrivalTime <= endTime)
            );
        }

        public (int TotalSeats, decimal AveragePrice) GetAggregateData()
        {
            int totalSeats = schedules.Sum(s => s.SeatsAvailable);
            decimal avgPrice = schedules.Average(s => s.Price);
            return (totalSeats, avgPrice);
        }

        public IEnumerable<(string Route, DateTime DepartureTime)> GetRouteAndDepartureTimes()
        {
            return schedules.Select(s => (s.Route, s.DepartureTime));
        }
    }
}