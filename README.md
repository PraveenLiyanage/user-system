# Student Registration System

Simple student registration system using:

- Flutter (Web) – Student UI
- ASP.NET Core Web API – Backend
- SQL Server 2022 – Database (Stored Procedures)

## Features

- Create / View / Update / Delete student profiles
- Stored-procedure-based CRUD in SQL Server
- Flutter UI with search, cards, and animations
- Separation of concerns: DB ↔ Repository ↔ Controller ↔ Flutter service

## Architecture

Student App (Flutter) → ApiService (HTTP) → ASP.NET Controllers → Repository → Stored Procedures → SQL Server

## Tech Stack

- Flutter 3.x
- Dart
- ASP.NET Core 8 (C#)
- SQL Server 2022
- Postman (API testing)

## How to Run

### Backend

1. Update connection string in `appsettings.Development.json`.
2. Run migrations / run SQL script to create DB + tables + stored procedures.
3. In `UserSys` folder:

   ```bash
   dotnet run
   ```

### Frontend

   ```bash
   flutter pub get
   flutter run -d chrome
   ```
