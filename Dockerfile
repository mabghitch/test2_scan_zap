#telecharge l image stage 1
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source
COPY *.csproj .
RUN dotnet restore

#publication application 
COPY . .
RUN dotnet publish *.csproj -c release -o /app1
#RUN dotnet publish -c release -o /app1


#stage 2
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app1
COPY --from=build /app1 .
ENTRYPOINT [ "dotnet", "fthapp.dll" ]


