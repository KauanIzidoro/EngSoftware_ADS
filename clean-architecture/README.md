# Clean Architecture

```mermaid
%% Comprehensive Clean Architecture Diagram

%% Define global styles for better visual differentiation
graph TD
    classDef default fill:#FAFAFA,stroke:#333,stroke-width:2px, color: #000;
    classDef entities fill:#C5CAE9,stroke:#3F51B5,stroke-width:2px,stroke-dasharray: 5 5, color: #000;
    classDef usecases fill:#F8BBD0,stroke:#E91E63,stroke-width:2px,stroke-dasharray: 5 5, color: #000;
    classDef controllers fill:#FFE0B2,stroke:#FF6F00,stroke-width:2px,stroke-dasharray: 5 5, color: #000;
    classDef database fill:#BBDEFB,stroke:#1E88E5,stroke-width:2px,stroke-dasharray: 5 5, color: #000;
    classDef external fill:#C8E6C9,stroke:#4CAF50,stroke-width:2px,stroke-dasharray: 5 5, color: #000;
    classDef layer fill:none,stroke:#333,stroke-width:2px,stroke-dasharray: 5 5;

    %% Layers and their components
    subgraph L0 ["External Systems"]
    class L0 layer
        direction TB
        UserInterface["📱 User Interface\n(Web or Mobile App)"]:::external
        SystemConnector["🔗 System Connector\n(External System)"]:::external
    end

    subgraph L1 ["Frameworks & Drivers Layer"]
    class L1 layer
        direction TB
        WebFramework["🌍 Web Framework"]:::controllers
        ORM["📚 ORM\n(Database Mapper)"]:::database
        SQLEngine["🗄️ SQL Engine"]:::database

        %% Connections within Frameworks & Drivers Layer
        ORM -->|Maps| SQLEngine
    end

    subgraph L2 ["Interface Adapters Layer"]
    class L2 layer
        direction TB
        CheckoutController["🖥️ Checkout Controller"]:::controllers
        InventoryController["📋 Inventory Controller"]:::controllers
        CheckoutPresenter["📤 Checkout Presenter"]:::controllers
        InventoryPresenter["📋 Inventory Presenter"]:::controllers
        
        %% Connections within Interface Adapters Layer
        CheckoutController -->|Calls| CheckoutUseCase
        InventoryController -->|Calls| InventoryUseCase
        CheckoutPresenter --> CheckoutUseCase
        InventoryPresenter --> InventoryUseCase
    end

    subgraph L3 ["Application Layer - Use Cases"]
    class L3 layer
        direction TB
        CheckoutUseCase["🔄 Checkout Use Case"]:::usecases
        InventoryUseCase["📦 Inventory Use Case"]:::usecases
        OrderRepository["🗂️ Order Repository\n(Interface)"]:::usecases
        PaymentService["💳 Payment Service\n(Interface)"]:::usecases

        %% Connections within Application Layer
        CheckoutUseCase --> OrderRepository
        CheckoutUseCase --> PaymentService
        InventoryUseCase --> OrderRepository
        OrderRepository -->|Uses| Order
    end

    subgraph L4 ["Core Layer - Entities"]
    class L4 layer
        direction TB
        Order["💼 Order\n(Entity)"]:::entities
        Product["📦 Product\n(Entity)"]:::entities
        Customer["👤 Customer\n(Entity)"]:::entities

        %% Connections within Core Layer
        Order -->|Contains| Product
    end

    %% External connections
    UserInterface -->|Sends Requests to| WebFramework
    SystemConnector -->|Fetches Data from| SQLEngine

    %% Layer-to-Layer connections (Cross-Layer interactions)
    WebFramework --> CheckoutController
    WebFramework --> InventoryController
    ORM --> OrderRepository
    SQLEngine --> OrderRepository
    PaymentService --> SystemConnector

    %% Define overall boundary to enclose all layers (not technically in Mermaid syntax, for conceptual visualization)
    %% subgraph FullDiagram ["Comprehensive Clean Architecture Diagram"]
    %% end
```

Este sistema segue os princípios da **Clean Architecture**, separando as responsabilidades em camadas independentes. Esta arquitetura visa manter a lógica de negócios isolada de interfaces e infraestrutura, facilitando a manutenção e escalabilidade. Abaixo está uma explicação detalhada de cada camada e suas interações.

---

## 1. Camada de Sistemas Externos
- **Interface do Usuário** (`📱`): Representa a interface gráfica da aplicação, seja web ou mobile, que envia requisições para os controladores na camada de **Frameworks & Drivers**.
- **Conector de Sistema** (`🔗`): Um sistema externo que interage com o banco de dados ou outros serviços da aplicação, como APIs externas.

**Interações**:
- A **Interface do Usuário** envia requisições diretamente para o **Web Framework** na camada de **Frameworks & Drivers**.
- O **Conector de Sistema** acessa dados por meio do **SQL Engine**.

---

## 2. Camada de Frameworks e Drivers
- **Web Framework** (`🌍`): Framework que gerencia requisições HTTP, processando as solicitações da **Interface do Usuário** e repassando-as aos controladores da camada de **Adaptadores de Interface**.
- **ORM (Object-Relational Mapper)** (`📚`): Mapeia as entidades da camada de **Entidades** para o banco de dados relacional.
- **SQL Engine** (`🗄️`): Banco de dados SQL que armazena as informações da aplicação, como pedidos e produtos.

**Interações**:
- O **Web Framework** envia as requisições para os controladores da camada de **Adaptadores de Interface**.
- O **ORM** se comunica com o **Repositório de Pedidos** e o **SQL Engine** para persistir os dados.

---

## 3. Camada de Adaptadores de Interface
- **Checkout Controller** (`🖥️`): Controlador responsável pelo processo de checkout, recebendo requisições do **Web Framework** e chamando o **Caso de Uso de Checkout**.
- **Inventory Controller** (`📋`): Controlador que gerencia o inventário, invocando o **Caso de Uso de Inventário**.
- **Checkout Presenter** (`📤`): Apresentador que coleta e formata a saída do **Caso de Uso de Checkout** para a interface do usuário.
- **Inventory Presenter** (`📋`): Apresenta dados de inventário após a execução do **Caso de Uso de Inventário**.

**Interações**:
- Os controladores, como o **Checkout Controller**, chamam diretamente os respectivos casos de uso.
- Os apresentadores formatam os dados dos casos de uso para exibição na **Interface do Usuário**.

---

## 4. Camada de Aplicação - Casos de Uso
- **Checkout Use Case** (`🔄`): Lógica de negócio relacionada ao checkout, interagindo com o **Repositório de Pedidos** e o **Serviço de Pagamento**.
- **Inventory Use Case** (`📦`): Lógica de inventário, consultando o **Repositório de Pedidos**.
- **Order Repository** (`🗂️`): Interface que define operações de persistência das entidades de **Pedidos**.
- **Payment Service** (`💳`): Serviço responsável por processar pagamentos, frequentemente conectado a sistemas externos.

**Interações**:
- O **Checkout Use Case** e o **Inventory Use Case** utilizam o **Order Repository** para gerenciar os dados.
- O **Payment Service** é acionado pelo **Checkout Use Case** para processar pagamentos.

---

## 5. Camada Core - Entidades
- **Order** (`💼`): Representa a entidade de pedidos, que contém produtos e clientes.
- **Product** (`📦`): Entidade que descreve os produtos, com características como preço e quantidade.
- **Customer** (`👤`): Armazena dados dos clientes, como nome e endereço.

**Interações**:
- A entidade **Order** contém um ou mais **Products**.
- As entidades são manipuladas pelos casos de uso e persistidas através do **Order Repository**.

---

## Fluxo Geral de Dados
1. A **Interface do Usuário** envia uma requisição para o **Web Framework**.
2. O **Web Framework** repassa a requisição para o controlador adequado, como o **Checkout Controller**, que invoca o **Caso de Uso de Checkout**.
3. O **Caso de Uso de Checkout** acessa o **Repositório de Pedidos** para manipular dados e processar pagamentos via o **Serviço de Pagamento**.
4. O **Repositório de Pedidos** se comunica com o **ORM** para acessar o banco de dados.
5. Os apresentadores formatam a saída do caso de uso para ser exibida na **Interface do Usuário**.
6. O usuário visualiza a resposta processada pela interface.
