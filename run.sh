#!/bin/bash

docker build --no-cache -t dotnet6-nuget-test . && docker run --rm dotnet6-nuget-test
