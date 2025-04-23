# _ShelfSaver_ Development Report

Welcome to the documentation pages of _ShelfSaver_!

This Software Development Report, tailored for LEIC-ES-2024-25, provides comprehensive details about _ShelfSaver_, from high-level vision to low-level implementation decisions. It’s organised by the following activities. 

* [Business modeling](#Business-Modelling) 
  * [Product Vision](#Product-Vision)
  * [Features and Assumptions](#Features-and-Assumptions)
  * [Elevator Pitch](#Elevator-pitch)
* [Requirements](#Requirements)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* [Architecture and Design](#Architecture-And-Design)
  * [Logical architecture](#Logical-Architecture)
  * [Physical architecture](#Physical-Architecture)
  * [Vertical prototype](#Vertical-Prototype)
* [Project management](#Project-Management)
  * [Sprint 0](#Sprint-0)
  * [Sprint 1](#Sprint-1)
  * [Sprint 2](#Sprint-2)
  * [Sprint 3](#Sprint-3)
  * [Sprint 4](#Sprint-4)
  * [Final Release](#Final-Release)

Contributions are expected to be made exclusively by the initial team, but we may open them to the community, after the course, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

* Filipe Paiva            up202304284@up.pt
* João Pedro Martins      up202207341@up.pt
* Raul Oliveira           up202303446@up.pt
* Tiago Almeida           up202303450@up.pt


---
## Business Modelling

Business modeling in software development involves defining the product's vision, understanding market needs, aligning features with user expectations, and setting the groundwork for strategic planning and execution.

### Product Vision

Turning last-chance products into first-choice deals—reducing waste, saving money, and connecting smart shoppers with great discounts.

### Features and Assumptions

**Discounted Marketplace** – Customers can buy surplus food and unsold clothes at significantly reduced prices.

**Real-Time Inventory Updates** – Businesses can update stock levels dynamically to avoid over-listing. 

**Business Partnerships** – Stores, restaurants, and retailers can list their surplus items. 

**Wishlist & Favorites** – Customers can save favorite stores or products for later.

### Elevator Pitch
<!-- 
Draft a small text to help you quickly introduce and describe your product in a short time (lift travel time ~90 seconds) and a few words (~800 characters), a technique usually known as elevator pitch.

Take a look at the following links to learn some techniques:
* [Crafting an Elevator Pitch](https://www.mindtools.com/pages/article/elevator-pitch.htm)
* [The Best Elevator Pitch Examples, Templates, and Tactics - A Guide to Writing an Unforgettable Elevator Speech, by strategypeak.com](https://strategypeak.com/elevator-pitch-examples/)
* [Top 7 Killer Elevator Pitch Examples, by toggl.com](https://blog.toggl.com/elevator-pitch-examples/)
-->

## Requirements

### User Stories

#### _User Story #1: **Implement Browsing Functionalities (Food)**_
    
As a Client, I want to browse about-to-expire supermarket products on sale, so that I can save money and support sustainable consumer habits.  

**Mockup:**

![ShopMockUp](https://github.com/user-attachments/assets/4a347b44-8eb0-408b-aac7-8644130f9cdc)


**Acceptance Tests**
```gherkin
    Given I am a registered user
    When I navigate to the supermarket products section
    Then I should see a list of available about-to-expire discounted products
    And each product should display the discount, expiration date, and store location

```

**Value:** Must Have

**Effort:** M

#### _User Story #2: **Implement Browsing Functionalities (Clothing)**_

As a Client, I want to find clothing items that are about to be removed from stores, so that I can make affordable purchases while reducing fashion waste.

**Mockup:**

![ClothesMockUp](https://github.com/user-attachments/assets/2666f9fa-5650-4573-b37f-7180b1cfec26)


**Acceptance Tests**
```gherkin
    Given I am a registered user
    When I navigate to the clothing section
    Then I should see a list of clothing items that are about to be removed from stores
    And each item should display the discount, removal date, and store location
```
**Value:** Must Have

**Effort:** M

#### _User Story #3: **Implement Business Sign-up**_

As a Business, I want to register my store on the app, so that I can gain visibility and attract clients for my discounted products.

**Mockup:**

![Business Registration](https://github.com/user-attachments/assets/87ca36c4-371c-41f0-a6f6-f55d42966d16)


**Acceptance Tests**
```gherkin
    Given I am a business owner
    When I navigate to the store registration page
    And I provide valid store details (name, address, category, contact info)
    Then my store should be successfully registered and visible to clients
```

**Value:** Must Have

**Effort:** S

#### _User Story #4: **Implement a Way for Businesses to Add New Products**_

As a Business, I want to add new about-to-expire products to the app, so that customers are aware of my store’s offers and I can reduce waste.

**Acceptance Tests**
```gherkin
    Given I am a registered business user
    When I navigate to the product listing page
    And I enter the product details (name, price, discount, expiration date, category)
    Then the product should be added and visible to clients in the relevant section
```

**Value:** Must Have

**Effort:** M

#### _User Story #5: **Implement a Way For The App To Notify Users About Newly Added Products**_

As a Business, I want the app to notify users about my discounted product catalog, so that I can efficiently clear out my inventory.

**Acceptance Tests**
```gherkin
    Given I am a business user with products listed
    When a product is added or updated with a discount
    Then users who have opted in for notifications should receive an alert
```

**Value:** Should Have

**Effort:** L

#### _User Story #6: **Implement a "Favourites" Functionality**_

As a Client, I want to save my favorite discounted products, so that I can quickly access them before they expire.

**Mockup:**

![FavouritesMockUp](https://github.com/user-attachments/assets/3f9b0fd6-48ba-4058-97ce-ed4d786dc756)


**Acceptance Tests**
```gherkin
    Given I am a logged-in client
    And I am browsing discounted products
    When I click the "Add to Favorites" button on a product
    Then the product should be added to my favorites list
```

**Value:** Could Have

**Effort:** M

#### _User Story #7: **Implement Product Stats For Businesses**_

As a Business, I want to see reports on which discounted items sell best, so that I can optimize future offers.

**Acceptance Tests**
```gherkin
    Given I am a logged-in business owner
    And I have previously listed discounted products
    When I navigate to the "Sales Reports" section
    Then I should see a report of discounted products with sales data
```

**Value:** Could Have

**Effort:** XL

### Domain model

![image](https://github.com/user-attachments/assets/3c90e070-c817-4c35-acd5-ca182875436c)





## Architecture and Design
<!--
The architecture of a software system encompasses the set of key decisions about its organization. 

A well written architecture document is brief and reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them. 

In this section you should start by briefly describing the components of the project and their interrelations. You should describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.
-->


### Logical architecture

The diagram organizes components into packages like Authentication, Registration, and Product Management, depicting navigation between login, registration, and product category screens.
![image](https://github.com/user-attachments/assets/dd4b8a7a-2af1-4847-b1b3-c3c06c890f22)


### Physical architecture

This diagram shows the system's structure, with frontend devices (Client and Business smartphones) interacting with Firebase services (Authentication, Firestore, and Cloud Functions) for user management, product browsing, and business operations.
![image](https://github.com/user-attachments/assets/81d81a2c-4acc-4661-ab70-00673205df54)


### Vertical prototype
<!--
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system integrating as much technologies we can.

In this subsection please describe which feature, or part of it, you have implemented, and how, together with a snapshot of the user interface, if applicable.

At this phase, instead of a complete user story, you can simply implement a small part of a feature that demonstrates thay you can use the technology, for example, show a screen with the app credits (name and authors).
-->

## Project management
<!--
Software project management is the art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.

In the context of ESOF, we recommend each team to adopt a set of project management practices and tools capable of registering tasks, assigning tasks to team members, adding estimations to tasks, monitor tasks progress, and therefore being able to track their projects.

Common practices of managing agile software development with Scrum are: backlog management, release management, estimation, Sprint planning, Sprint development, acceptance tests, and Sprint retrospectives.

You can find below information and references related with the project management: 

* Backlog management: Product backlog and Sprint backlog in a [Github Projects board](https://github.com/orgs/FEUP-LEIC-ES-2023-24/projects/64);
* Release management: [v0](#), v1, v2, v3, ...;
* Sprint planning and retrospectives: 
  * plans: screenshots of Github Projects board at begin and end of each Sprint;
  * retrospectives: meeting notes in a document in the repository, addressing the following questions:
    * Did well: things we did well and should continue;
    * Do differently: things we should do differently and how;
    * Puzzles: things we don’t know yet if they are right or wrong… 
    * list of a few improvements to implement next Sprint;

-->

### Sprint 0
Spring Backlog:
![Captura de ecrã 2025-04-01 111109](https://github.com/user-attachments/assets/34bc2503-ec4c-4db9-b52f-9eff0096f148)

Sprint Review:
![Captura de ecrã 2025-04-01 111146](https://github.com/user-attachments/assets/6af16ed8-6a98-4e1a-bc4a-f8392b723cd7)

### Sprint 1
Sprint Backlog:
![imagem](https://github.com/user-attachments/assets/c18c74db-28d3-4018-8113-5c819b18c6dc)

Sprint Review:
![image](https://github.com/user-attachments/assets/b0801d49-73f7-4f9b-88a0-074bfcb9bccf)

What we implemented during this sprint:

- Login and Sign Up Authentication added for Users and Businesses using Firebase
- Basic simple search for Clothes
- Ability to add Clothes through a Database
- New Page where Businesses are going to be able to add new products (for now it's just the page, not supported by any logic)

What needs improvement:

- Simple search should not only work for exact searches (ex: jacket should return Jacket and not Null). Search with string contains instead of exact matches
- Have a message pop up when user/business uses wrong login data instead of the default one
- Implement the logic behind adding new products by adding them to the respective databases
- Polish the app in general (the looks of the Clothing and Food pages are still very functional and not appealing)

Happiness Meter:
| | Filipe | João | Raul | Tiago |
|-| ------ | ---- | ---- | ----- |
| Filipe |😊|⭐️|⭐️|⭐️|
| João |⭐️|⭐️|⭐️|⭐️|
| Raul | | | | |
| Tiago |😊|⭐️|⭐️|😊|

### Sprint 2
Planning of Sprint 2:

![image](https://github.com/user-attachments/assets/ce8f7bc2-5e63-4b82-95bf-1d9be37cd6a9)

| | Filipe | João | Raul | Tiago |
|-| ------ | ---- | ---- | ----- |
| Filipe | | | | |
| João | | | | |
| Raul | | | | |
| Tiago | | | | |

### Sprint 3

| | Filipe | João | Raul | Tiago |
|-| ------ | ---- | ---- | ----- |
| Filipe | | | | |
| João | | | | |
| Raul | | | | |
| Tiago | | | | |

### Sprint 4

| | Filipe | João | Raul | Tiago |
|-| ------ | ---- | ---- | ----- |
| Filipe | | | | |
| João | | | | |
| Raul | | | | |
| Tiago | | | | |

### Final Release


