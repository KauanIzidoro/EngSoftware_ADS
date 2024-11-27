#!/bin/bash

# Diretório base do projeto
PROJECT_DIR="CleanArchProject"
mkdir -p "$PROJECT_DIR"

# Presentation Systems
mkdir -p "$PROJECT_DIR/CleanArchPresentation"
touch "$PROJECT_DIR/CleanArchPresentation/UserInterface.cs"
touch "$PROJECT_DIR/CleanArchPresentation/SystemConnector.cs"
touch "$PROJECT_DIR/CleanArchPresentation/Program.cs"

# Frameworks & Drivers (Infrastructure) Layer
mkdir -p "$PROJECT_DIR/CleanArchInfrastructure"
touch "$PROJECT_DIR/CleanArchInfrastructure/WebFramework.cs"
touch "$PROJECT_DIR/CleanArchInfrastructure/Orm.cs"
touch "$PROJECT_DIR/CleanArchInfrastructure/SqlEngine.cs"

# Application Layer - Use Cases
mkdir -p "$PROJECT_DIR/CleanArchApplication"
touch "$PROJECT_DIR/CleanArchApplication/Checkout.cs"
touch "$PROJECT_DIR/CleanArchApplication/Inventory.cs"
touch "$PROJECT_DIR/CleanArchApplication/MakeOrder.cs"
touch "$PROJECT_DIR/CleanArchApplication/PaymentService.cs"

# Domain Layer - Entities
mkdir -p "$PROJECT_DIR/CleanArchDomain"
touch "$PROJECT_DIR/CleanArchDomain/Order.cs"
touch "$PROJECT_DIR/CleanArchDomain/Product.cs"
touch "$PROJECT_DIR/CleanArchDomain/Customer.cs"
touch "$PROJECT_DIR/CleanArchDomain/StockManager.cs"

clear
cd CleanArchProject/
echo "Criando setup Clean..."
sleep 3
echo "Clean setup criado: "
sleep 1.7
tree
cd ..
rm -r CleanArchProject/

