using Microsoft.AspNetCore.Mvc;
using UserSysApi.Models;
using UserSysApi.Services;

namespace UserSysApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController:ControllerBase
    {
        private readonly UserRepository _repo;

        public UserController(UserRepository repo)
        {
            _repo = repo;
        }

        //Get api/user
        [HttpGet]
        public async Task<ActionResult> GetAll()
        {
            var users = await _repo.GetAllAsync();
            return Ok(users);
        }

        // Get api/user/{id}
        [HttpGet("{id:int}")]
        public async Task<ActionResult> GetById(int id)
        {
            var user = await _repo.GetByIdAsync(id);
            if (user == null)
            {
                return NotFound();
            }
            return Ok(user);
        }

        // POST api/user
        [HttpPost]
        public async Task<ActionResult> Create([FromBody] UserDto dto)
        {
            if (string.IsNullOrWhiteSpace(dto.Name) || string.IsNullOrWhiteSpace(dto.Email))
            {
                return BadRequest("Name and Email are required.");
            }

            var newId = await _repo.CreateAsync(dto);
            dto.Id = newId;
            dto.CreatedAt = DateTime.UtcNow;

            return CreatedAtAction(nameof(GetById), new { id = newId }, dto);
        }

        // PUT api/user/{id}
        [HttpPut("{id:int}")]
        public async Task<ActionResult> Update(int id, [FromBody] UserDto dto)
        {
        if (id != dto.Id)
        {
            return BadRequest("Your ID was not matched.");
        }

            var ok = await _repo.UpdateAsync(dto);
            if (!ok)
            {
                return NotFound();
            }
            return NoContent();
        }

        // DELETE api/user/{id}
        [HttpDelete("{id:int}")]
        public async Task<ActionResult> Delete(int id)
        {
            var ok = await _repo.DeleteAsync(id);
            if (!ok)
            {
                return NotFound();
            }
            return NoContent();
        }
    }
}