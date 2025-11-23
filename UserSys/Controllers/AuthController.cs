using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;
using BCrypt.Net;
using UserSysApi.Models.Auth;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.VisualBasic;

namespace UserSysApi.Controllers
{
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly string _connString;

        public AuthController(IConfiguration config)
        {
        _connString = config.GetConnectionString("DefaultConnection")
        ?? throw new InvalidOperationException("Connection String not Found");
        }

        // POST : Api auth configuration
        [HttpPost("register")]
        public async Task<ActionResult<LoggedinUserDto>> Register([FromBody]RegisterDto dto)
        {
        if (string.IsNullOrWhiteSpace(dto.Email) || string.IsNullOrWhiteSpace(dto.Password))
        {
            return BadRequest("Email and Password are Required");
        }

        using var conn = new SqlConnection(_connString);
        await conn.OpenAsync();

        // Check if email already exists
        var checkCmd = new SqlCommand("SELECT COUNT (1) FROM AppUsers WHERE Email = @Email", conn);
        checkCmd.Parameters.AddWithValue("@Email", dto.Email);

        var exists = (int)await checkCmd.ExecuteScalarAsync() > 0;

        if(exists)
            {
                return Conflict("Email already registered.");
            }

            //Hash Password
            var Hash = BCrypt.Net.BCrypt.HashPassword(dto.Password);

            //Insert User
            var cmd = new SqlCommand(@"
                INSERT INTO AppUsers (Email, PasswordHash, Name)
                VALUES (@Email, @PasswordHash, @Name);
                SELECT SCOPE_IDENTITY();", conn);

            cmd.Parameters.AddWithValue("@Email", dto.Email);
            cmd.Parameters.AddWithValue("@PasswordHash", Hash);
            cmd.Parameters.AddWithValue("@Name", dto.Name);

            var result = await cmd.ExecuteScalarAsync();
            int newId = Convert.ToInt32(result);

            var user = new LoggedinUserDto
            {
                Id = newId,
                Name = dto.Name,
                Email = dto.Email
            };

            return CreatedAtAction(nameof(GetMe), new {id = newId}, user);
        }

        //POST: api/auth/login
        [HttpPost("login")]
            public async Task<ActionResult<LoggedinUserDto>> Login([FromBody]LoginDto dto)
        {

        using var conn = new SqlConnection(_connString);
        await conn.OpenAsync();

        var checkCmd = new SqlCommand("SELECT TOP 1 Id, Name, Email, PasswordHash FROM AppUsers WHERE Email = @Email", conn);
        checkCmd.Parameters.AddWithValue("@Email", dto.Email);

        using var reader = await checkCmd.ExecuteReaderAsync();
        if (!await reader.ReadAsync())
            {
                return Unauthorized("Invalied email or Password.");
            }

            int id = reader.GetInt32(0);
            string name = reader.GetString(1);
            string email = reader.GetString(2);
            string PasswordHash = reader.GetString(3);

            //Verify Pass
            bool ok = BCrypt.Net.BCrypt.Verify(dto.Password, PasswordHash);

            if (!ok)
            {
                return Unauthorized("Invalied email or Password.");
            }

            var user = new LoggedinUserDto
            {
                Id = id,
                Name = name,
                Email = email
            };

            return Ok(user);
        }

        [HttpGet("me/{id:int}")]
        public ActionResult<LoggedinUserDto> GetMe(int id)
        {
            return NotFound();
        }
    }
}