FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY Main.class .

CMD ["java", "Main"]