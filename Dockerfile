FROM mcr.microsoft.com/dotnet/aspnet:6.0-bullseye-slim AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0-bullseye-slim AS build
WORKDIR /source
COPY ["DockerTest.csproj", "./"]
RUN dotnet nuget add source "https://api.nuget.org/v3/fake.json" --name private --username "test" --password "test" --store-password-in-clear-text
RUN dotnet restore "DockerTest.csproj"
COPY . .
RUN dotnet build "DockerTest.csproj" -c Release

FROM build AS publish
WORKDIR /source
RUN dotnet publish "DockerTest.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT dotnet DockerTest.dll

