namespace UserSysApi.Models
{
    public class UserDto
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string Email { get; set; }
        public string? DegreeProgram { get; set; }
        public string? Specialization { get; set; }
        public string? University { get; set; }
        public string? RegistrationNumber { get; set; }
        public int? BatchYear { get; set; }
        public DateTime CreatedAt { get; set; } 
    }
}