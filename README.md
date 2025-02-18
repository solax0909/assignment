# Flutter and Java Spring Boot Application Usage Guide

## Introduction

This application is developed with Flutter (front-end) for the mobile application and Java Spring Boot (back-end) for the API server. The database used is SQL Server.

- **Front-end**: Flutter (Mobile Application)
- **Back-end**: Java Spring Boot (API Server)
- **Database**: SQL Server

## System Requirements

- **Flutter**:
  - Flutter SDK (version 3.7.0 or higher)
  - Dart SDK (must be compatible with Flutter)
  - Android Studio or VS Code (with Flutter Plugin)
  
- **Java Spring Boot**:
  - JDK 17 or higher
  - Maven for managing dependencies
  
- **Database**:
  - SQL Server 2019 or higher

## Environment Setup

### Backend Setup (Java Spring Boot)

1. **Install JDK**:
   - Download and install JDK 17 or higher from [Oracle JDK](https://www.oracle.com/java/technologies/javase-jdk17-downloads.html).

2. **Install Maven** (if you are using Maven to build the project):
   - Download and install Maven from [Maven Website](https://maven.apache.org/download.cgi).
   - Configure the environment variable `MAVEN_HOME` and add its path to `PATH`.

3. **Configure Backend Project**:
   - Clone your backend repository:
     ```bash
     git clone https://github.com/solax0909/assignment.git
     cd user
     ```
   - Install Maven dependencies:
     ```bash
     mvn install
     ```

4. **Configure Database**:
   - Make sure you have a running SQL Server.
   - Update the database connection details in the `application.yml` file of Spring Boot:
     ```yaml
     server:
       port: 8088
     
     spring:
       datasource:
         url: jdbc:sqlserver://localhost:1433;databaseName=db_personal
         username: sa
         password: 123
       jpa:
         hibernate:
           ddl-auto: update
         show-sql: true
     ```

5. **Run Backend**:
   - Run the Spring Boot application:
     ```bash
     mvn spring-boot:run
     ```
   - Or click run button in IDE to Run backend service
   - The application will run on port `8088` (configured in `application.yml`).

### Frontend Setup (Flutter)

1. **Install Flutter**:
   - Download and install Flutter from [Flutter Website](https://flutter.dev/docs/get-started/install).
   - Set up the environment by adding `flutter/bin` to the `PATH` environment variable.

2. **Install Android Studio or VS Code**:
   - Download and install Android Studio or VS Code with the Flutter plugin.
   - Ensure you have an Android emulator or a physical device to run the app.

3. **Configure Flutter Project**:
   - Clone the front-end repository:
     ```bash
     git clone https://github.com/solax0909/assignment.git
     cd user_flutter
     ```

4. **Install Dependencies**:
   - Install Flutter dependencies:
     ```bash
     flutter pub get
     ```

5. **Run Flutter Application**:
   - Run the application on your device or emulator:
     ```bash
     flutter run
     ```
   - The app will run on your Android/iOS device.

### API Testing

After configuring and running both the Spring Boot and Flutter applications, you can test the API:

- The backend APIs will run at `http://localhost:8088`.
- Use tools like [Postman](https://www.postman.com/) to test the API endpoints.

## Key Features

- **Flutter App**: A mobile app that allows users to interact with services via APIs provided by the back-end.
- **API (Spring Boot)**: API endpoints that allow the front-end to interact with the data stored in the database.
- **SQL Server**: Database storing application data.

## Documentation

- [Flutter Documentation](https://flutter.dev/docs)
- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [SQL Server Documentation](https://docs.microsoft.com/en-us/sql/sql-server/)
  
## Contact

- **Email**: solax0909@gmail.com
- **GitHub**: [https://github.com/solax0909](https://github.com/solax0909)
