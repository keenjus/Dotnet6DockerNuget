# What is this?
This is an example of how .NET 6 SDK in Docker crashes when using `dotnet nuget` commands on a Raspberry Pi 4

```sh
docker build --no-cache -t dotnet6-nuget-test . && docker run --rm dotnet6-nuget-test
# or just
./run.sh
```

# Running on raspbian (Raspberry Pi4 8gb)
```sh
Sending build context to Docker daemon  103.9kB
Step 1/16 : FROM mcr.microsoft.com/dotnet/aspnet:6.0-bullseye-slim AS base
 ---> 884fc1f06479
Step 2/16 : WORKDIR /app
 ---> Running in 2495ac22cda8
Removing intermediate container 2495ac22cda8
 ---> 5b3853384777
Step 3/16 : FROM mcr.microsoft.com/dotnet/sdk:6.0-bullseye-slim AS build
 ---> 2d3345bf43be
Step 4/16 : WORKDIR /source
 ---> Running in 1c29bb2f5508
Removing intermediate container 1c29bb2f5508
 ---> 8545546232bb
Step 5/16 : COPY ["Dotnet6DockerNuget.csproj", "./"]
 ---> e91ccb7a3e6a
Step 6/16 : RUN dotnet nuget add source "https://api.nuget.org/v3/fake.json" --name private --username "test" --password "test" --store-password-in-clear-text
 ---> Running in eafc16002e9f
Aborted (core dumped)
The command '/bin/sh -c dotnet nuget add source "https://api.nuget.org/v3/fake.json" --name private --username "test" --password "test" --store-password-in-clear-text' returned a non-zero code: 134
```

# Running on x64 Ubuntu 21.10

```sh
Sending build context to Docker daemon  102.4kB
Step 1/16 : FROM mcr.microsoft.com/dotnet/aspnet:6.0-bullseye-slim AS base
 ---> 2fc5b10637a6
Step 2/16 : WORKDIR /app
 ---> Running in be046e6c4144
Removing intermediate container be046e6c4144
 ---> a3bd9f956835
Step 3/16 : FROM mcr.microsoft.com/dotnet/sdk:6.0-bullseye-slim AS build
 ---> 9c1e3c82ea06
Step 4/16 : WORKDIR /source
 ---> Running in cdda5b4b1a06
Removing intermediate container cdda5b4b1a06
 ---> 9b7976fdf3c7
Step 5/16 : COPY ["Dotnet6DockerNuget.csproj", "./"]
 ---> adb619a9d2ed
Step 6/16 : RUN dotnet nuget add source "https://api.nuget.org/v3/fake.json" --name private --username "test" --password "test" --store-password-in-clear-text
 ---> Running in f1f25341ac1d
Package source with Name: private added successfully.
Removing intermediate container f1f25341ac1d
 ---> 8b5061d840b8
Step 7/16 : RUN dotnet restore "Dotnet6DockerNuget.csproj"
 ---> Running in f017611535a5
  Determining projects to restore...
  Restored /source/Dotnet6DockerNuget.csproj (in 103 ms).
Removing intermediate container f017611535a5
 ---> 943ad1c70470
Step 8/16 : COPY . .
 ---> 4e6a7ee9c823
Step 9/16 : RUN dotnet build "Dotnet6DockerNuget.csproj" -c Release
 ---> Running in 42c674f9b52a
Microsoft (R) Build Engine version 17.0.0+c9eb9dd64 for .NET
Copyright (C) Microsoft Corporation. All rights reserved.

  Determining projects to restore...
  All projects are up-to-date for restore.
  Dotnet6DockerNuget -> /source/bin/Release/net6.0/Dotnet6DockerNuget.dll

Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:03.21
Removing intermediate container 42c674f9b52a
 ---> 5ea96b9b5394
Step 10/16 : FROM build AS publish
 ---> 5ea96b9b5394
Step 11/16 : WORKDIR /source
 ---> Running in 0e7fe53db9b0
Removing intermediate container 0e7fe53db9b0

 ---> 33eb5f3c62f6
Step 12/16 : RUN dotnet publish "Dotnet6DockerNuget.csproj" -c Release -o /app/publish
 ---> Running in d8295018ab51
Microsoft (R) Build Engine version 17.0.0+c9eb9dd64 for .NET
Copyright (C) Microsoft Corporation. All rights reserved.

  Determining projects to restore...
  All projects are up-to-date for restore.
  Dotnet6DockerNuget -> /source/bin/Release/net6.0/Dotnet6DockerNuget.dll
  Dotnet6DockerNuget -> /app/publish/
Removing intermediate container d8295018ab51
 ---> 4372d22b94e4
Step 13/16 : FROM base AS final
 ---> a3bd9f956835
Step 14/16 : WORKDIR /app
 ---> Running in 6236cd4c3231
Removing intermediate container 6236cd4c3231
 ---> adf42092348b
Step 15/16 : COPY --from=publish /app/publish .
 ---> b231157bab42
Step 16/16 : ENTRYPOINT dotnet Dotnet6DockerNuget.dll
 ---> Running in 1e445a12e06a
Removing intermediate container 1e445a12e06a
 ---> bccfda2e4093
Successfully built bccfda2e4093
Successfully tagged dotnet6-nuget-test:latest
Hello, World!
```
