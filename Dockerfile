
#FROM microsoft/aspnetcore:2.0
#LABEL Name=netcore Version=0.0.1
#ARG source=.
#WORKDIR /app
#EXPOSE 3000
#COPY $source .
#ENTRYPOINT ["dotnet", "run", "--server.urls", "http://*:3000"]

FROM microsoft/aspnetcore-build:2.0 AS build
WORKDIR /code
COPY . .
RUN dotnet restore
RUN dotnet publish --output /output --configuration Release
FROM microsoft/aspnetcore:2.0
COPY --from=build /output /app
WORKDIR /app
ENTRYPOINT [ "dotnet", "TodoApi.dll" ]
