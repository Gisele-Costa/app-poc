# Build da aplicação
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app
# Copia os arquivos do projeto e restaura dependências
COPY *.csproj ./
RUN dotnet restore
# Copia o restante do código e compila
COPY . .  
RUN dotnet publish -c Release -o /out
# Etapa 2: Runtime (onde a app roda)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /out .
# Exponha a porta 80
EXPOSE 80
# Define o comando de inicialização da API
CMD ["dotnet", "app-poc.dll"]
