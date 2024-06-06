# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# Copy the project files and restore dependencies
COPY . .

# List files to debug directory structure
RUN ls -R

# Specify the solution file for dotnet restore
RUN dotnet restore code.sln

# Build and publish the application
RUN dotnet publish code.sln -c Release -o /app/publish

# Stage 2: Create the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy the published files from the build stage
COPY --from=build /app/publish .

# Set environment variables and expose the port
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Define the entry point for the container
ENTRYPOINT ["dotnet", "cs-ipsum.dll"]
