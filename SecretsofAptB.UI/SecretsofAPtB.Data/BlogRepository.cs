using System;
using System.Collections.Generic;
using System.Text;
using Dapper;
using SecretsofAptB.Models.Tables;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SecretsofAPtB.Data
{
    public class BlogRepository : IBlogRepository
    {
        private string _connectionString;
        public BlogRepository (IConfiguration con)
        {
            string _connectionString = con.GetConnectionString("Connection");
        }
        
        internal IDbConnection Connection
        {
            get
            {
                return new SqlConnection(_connectionString);
            }
        }

        public void CreateCategory(string name)
        {
            using(Connection)
            {
                DynamicParameters param = new DynamicParameters();
                param.Add(name);
                Connection.Open();
                Connection.Execute("CreateCategory",param, commandType: CommandType.StoredProcedure);
            }
        }


    }
}
