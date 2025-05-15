#-----------------STAGE 1(jar builder)------------------------

# Maven image
FROM maven:3.8.3-openjdk-17 AS builder

# Set working directory
WORKDIR	/app

# Copy source code from local to container
COPY . .

# Build application and skip test cases
RUN mvn clean install -DskipTests=true

#EXPOSE 8080
#ENTRYPOINT ["java", "-jar", "/expenseapp.jar"]


#-----------------STAGE 2(app build)------------------------

# Import small size java image
FROM openjdk:17-alpine

WORKDIR /app

# Copy build from stage 1 (builder)
COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar

# Expose application port 
EXPOSE 8080

# Start the application
CMD ["java", "-jar", "/app/target/expenseapp.jar"]
