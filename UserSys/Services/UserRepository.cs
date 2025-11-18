using System.Data;
using Microsoft.Data.SqlClient;
using UserSysApi.Models;

namespace UserSysApi.Services
{
    public class UserRepository
    {
        private readonly string _connectingString;

        public UserRepository(IConfiguration config)
        {
            _connectingString = config.GetConnectionString("DefaultConnection")
                ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
        }

        private SqlConnection GetConnection() => new SqlConnection(_connectingString);

        // Read Get All Users from DB
        public async Task<List<UserDto>> GetAllAsync()

        {
            var list = new List<UserDto>();

            using var conn = GetConnection();
            using var cmd = new SqlCommand("sysUser_GetAll", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            await conn.OpenAsync();
            using var reader = await cmd.ExecuteReaderAsync();

            int ordId = reader.GetOrdinal("Id");
            int ordName = reader.GetOrdinal("Name");
            int ordEmail = reader.GetOrdinal("Email");
            int ordDegree = reader.GetOrdinal("DegreeProgram");
            int ordSpec = reader.GetOrdinal("Specialization");
            int ordUni = reader.GetOrdinal("University");
            int ordReg = reader.GetOrdinal("RegistrationNumber");
            int ordBatch = reader.GetOrdinal("BatchYear");
            int ordCreatedAt = reader.GetOrdinal("CreatedAt");

            while (await reader.ReadAsync())
            {
                var dto = new UserDto
                {
                    Id = reader.GetInt32(ordId),  
                    Name = reader.GetString(ordName),  
                    Email = reader.GetString(ordEmail),
                    DegreeProgram = reader.IsDBNull(ordDegree) ? null : reader.GetString(ordDegree),
                    Specialization = reader.IsDBNull(ordSpec) ? null : reader.GetString(ordSpec),
                    University = reader.IsDBNull(ordUni) ? null : reader.GetString(ordUni),
                    RegistrationNumber = reader.IsDBNull(ordReg) ? null : reader.GetString(ordReg),
                    BatchYear = reader.IsDBNull(ordBatch) ? null : reader.GetInt32(ordBatch),
                    CreatedAt = reader.GetDateTime(ordCreatedAt),
                    
                };

                list.Add(dto);
            }

            return list;
        }

        // READ - Get one by ID
        public async Task<UserDto?> GetByIdAsync(int id)
        {
            using var conn = GetConnection();
            using var cmd = new SqlCommand("sysUser_GetById", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", id);

            await conn.OpenAsync();
            using var reader = await cmd.ExecuteReaderAsync();

            if (!await reader.ReadAsync())
            return null;

            int ordId = reader.GetOrdinal("Id");
            int ordName = reader.GetOrdinal("Name");
            int ordEmail = reader.GetOrdinal("Email");
            int ordDegree = reader.GetOrdinal("DegreeProgram");
            int ordSpec = reader.GetOrdinal("Specialization");
            int ordUni = reader.GetOrdinal("University");
            int ordReg = reader.GetOrdinal("RegistrationNumber");
            int ordBatch = reader.GetOrdinal("BatchYear");
            int ordCreatedAt = reader.GetOrdinal("CreatedAt");

            return new UserDto
                {
                    Id = reader.GetInt32(ordId),  
                    Name = reader.GetString(ordName),  
                    Email = reader.GetString(ordEmail),
                    DegreeProgram = reader.IsDBNull(ordDegree) ? null : reader.GetString(ordDegree),
                    Specialization = reader.IsDBNull(ordSpec) ? null : reader.GetString(ordSpec),
                    University = reader.IsDBNull(ordUni) ? null : reader.GetString(ordUni),
                    RegistrationNumber = reader.IsDBNull(ordReg) ? null : reader.GetString(ordReg),
                    BatchYear = reader.IsDBNull(ordBatch) ? null : reader.GetInt32(ordBatch),
                    CreatedAt = reader.GetDateTime(ordCreatedAt),
                    
                };
            }

        // CREATE - Add new user
        public async Task<int> CreateAsync(UserDto dto)
        {
            using var conn = GetConnection();
            using var cmd = new SqlCommand("sysUser_Create", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Name", dto.Name);
            cmd.Parameters.AddWithValue("@Email", dto.Email);
            cmd.Parameters.AddWithValue("@DegreeProgram", (object?)dto.DegreeProgram ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@Specialization", (object?)dto.Specialization ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@University", (object?)dto.University ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@RegistrationNumber", (object?)dto.RegistrationNumber ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@BatchYear", (object?)dto.BatchYear ?? DBNull.Value);

            await conn.OpenAsync();
            var result = await cmd.ExecuteScalarAsync();
            return Convert.ToInt32(result);
        }

        // UPDATE - Update existing user
        public async Task<bool> UpdateAsync(UserDto dto)
        {
            using var conn = GetConnection();
            using var cmd = new SqlCommand("sysUser_Update", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Id", dto.Id);
            cmd.Parameters.AddWithValue("@Name", dto.Name);
            cmd.Parameters.AddWithValue("@Email", dto.Email);
            cmd.Parameters.AddWithValue("@DegreeProgram", (object?)dto.DegreeProgram ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@Specialization", (object?)dto.Specialization ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@University", (object?)dto.University ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@RegistrationNumber", (object?)dto.RegistrationNumber ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@BatchYear", (object?)dto.BatchYear ?? DBNull.Value);

            await conn.OpenAsync();
            var result = await cmd.ExecuteScalarAsync();
            int rows = Convert.ToInt32(result);
            return rows > 0;
        }

        // DELETE - Delete user by ID
        public async Task<bool> DeleteAsync(int id)
        {
            using var conn = GetConnection();
            using var cmd = new SqlCommand("sysUser_Delete", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", id);

            await conn.OpenAsync();
            var result = await cmd.ExecuteScalarAsync();
            int rows = Convert.ToInt32(result);
            return rows > 0;
        }
    }
}