FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

COPY . .

RUN dotnet restore cs-ipsum.ddl

RUN dotnet publish cs-ipsum.ddl -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Define the entry point for the container
ENTRYPOINT ["dotnet", "cs-ipsum.dll"]
