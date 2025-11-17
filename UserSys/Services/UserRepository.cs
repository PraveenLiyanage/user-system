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

            while (await reader.ReadAsync())
            {
                list.Add(new UserDto
                {
                    Id = reader.GetInt32(0),  
                    Name = reader.GetString(1),  
                    Email = reader.GetString(2),
                    CreatedAt = reader.GetDateTime(3),
                    DegreeProgram = reader.IsDBNull(4) ? null : reader.GetString(4),
                    Specialization = reader.IsDBNull(5) ? null : reader.GetString(5),
                    University = reader.IsDBNull(6) ? null : reader.GetString(6),
                    RegistrationNumber = reader.IsDBNull(7) ? null : reader.GetString(7),
                    BatchYear = reader.IsDBNull(8) ? null : reader.GetInt32(8),
                    
                });
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

            if (await reader.ReadAsync())
            {
                return new UserDto
                {
                    Id = reader.GetInt32(0),  
                    Name = reader.GetString(1),  
                    Email = reader.GetString(2),
                    CreatedAt = reader.GetDateTime(3),
                    DegreeProgram = reader.IsDBNull(4) ? null : reader.GetString(4),
                    Specialization = reader.IsDBNull(5) ? null : reader.GetString(5),
                    University = reader.IsDBNull(6) ? null : reader.GetString(6),
                    RegistrationNumber = reader.IsDBNull(7) ? null : reader.GetString(7),
                    BatchYear = reader.IsDBNull(8) ? null : reader.GetInt32(8),
                    
                };
            }

            return null;
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
            var rowsAffected = await cmd.ExecuteNonQueryAsync();
            return rowsAffected > 0;
        }

        // DELETE - Delete user by ID
        public async Task<bool> DeleteAsync(int id)
        {
            using var conn = GetConnection();
            using var cmd = new SqlCommand("sysUser_Delete", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", id);

            await conn.OpenAsync();
            var rowsAffected = await cmd.ExecuteNonQueryAsync();
            return rowsAffected > 0;
        }
    }
}