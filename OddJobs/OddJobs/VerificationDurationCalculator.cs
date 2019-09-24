using System;
using System.Collections.Generic;
using System.IO;
using System.Net;

namespace OddJobs
{
    public class VerificationDurationCalcualtor
    {
        private string filePath = @"C:\Users\Oliver.Kabi\source\repos\hackpad\OddJobs\Application Verification Test.csv";
        public void GetDurations()
        {
            var data = new List<Data>();
            using (var reader = new StreamReader(filePath))
            {
                reader.ReadLine();
                while (!reader.EndOfStream)
                {
                    var line = reader.ReadLine();
                    var values = line.Split(',');
                    data.Add(new Data
                    {
                        Token = Guid.Parse(values[0]),
                        TokenCreated = DateTime.Parse(values[1]).Subtract(TimeSpan.FromHours(23)),
                        VerifiedAt = DateTime.Parse(values[2])
                    });
                }
            }

        }
    }

    public class Data
    {
        public Guid Token { get; set; }
        public DateTime TokenCreated { get; set; }
        public DateTime VerifiedAt { get; set; }
    }
}