# lab_equipment_project
# Lab Equipment API

This is a Rails application designed to track the lab equipment and maintenance log for a university or research lab. It supports multiple CRUD actions and validation logic as required across specific tasks.

## Project Description
The API tracks three primary models: Category, Equipment, and MaintenanceRecord. Full RESTful operations are enabled across these layers.

## Task Assignment

| Task | Description | Assignee | Status |
| :--- | :--- | :--- | :--- |
| 1 | Database Creation and Core Model | Eyerus | Done |
| 2 | Seed Data | Hildana | Done |
| 3 | Category CRUD | Gelila | Done |
| 4 | Equipment CRUD with Filtering | Ephrata | Done |
| 5 | MaintenanceRecord CRUD with Filtering | Yohannes | Done |
| 6 | Business Rules | Hildana | Done |
| 7 | Edge Cases | Eyerus | Done |

## Setup Instructions

### Prerequisites
* Ruby v3.x
* Rails v8.x
* SQLite3

### Installation
To install, run the following commands in your terminal setup:
1. Clone the repository: git clone <your-repository-url>
2. Navigate into the directory: cd lab_equipment_project
3. Install dependencies: bundle install
4. Setup database schemas and apply seeds:
   bin/rails db:create
   bin/rails db:migrate
   bin/rails db:seed

### Running Tests
To run the test suite, run: bundle exec rspec

## Data Model

### Category
| Column | Type | Constraints |
| :--- | :--- | :--- |
| name | string | Required, unique, alphabetical list |

### Equipment
| Column | Type | Constraints |
| :--- | :--- | :--- |
| name | string | Required, sorted alphabetically on index |
| serial_number | string | Unique system-wide identifier |
| status | string | Required, values: operational, broken, maintenance. Default: operational |
| category_id | reference | Foreign key logic connection |

### MaintenanceRecord
| Column | Type | Constraints |
| :--- | :--- | :--- |
| description | text | Required |
| performed_at | datetime | Automatically defaulted to today |
| equipment_id | reference | Foreign key structural connection |

### Associations
* Category: Has many Equipment (dependent destroy safeguarded)
* Equipment: Belongs to Category, has many MaintenanceRecords (dependent cascade)
* MaintenanceRecord: Belongs to Equipment

## API Endpoints

### Categories
| Method | Path | Description |
| :--- | :--- | :--- |
| GET | /categories | Listed alphabetically by name |
| GET | /categories/:id | Custom layout includes equipment_count |
| POST | /categories | Create |
| PATCH | /categories/:id | Update |
| DELETE | /categories/:id | Safely blocked if associated items exist |

### Equipment
| Method | Path | Description |
| :--- | :--- | :--- |
| GET | /equipment | Listed alphabetically; optional status parameter query filter |
| GET | /equipment/:id | Includes category details and ordered logs history |
| POST | /equipment | Create |
| PATCH | /equipment/:id | Update |
| DELETE | /equipment/:id | Deletes cascades cleanly down to entries |

### MaintenanceRecords
| Method | Path | Description |
| :--- | :--- | :--- |
| GET | /maintenance_records | Ordered by date descending; optional equipment_id query filter |
| GET | /maintenance_records/:id | Shows matching record parameters |
| POST | /maintenance_records | Create |
| PATCH | /maintenance_records/:id | Update |
| DELETE | /maintenance_records/:id | Delete |

### Status Codes
| Status Case | Code |
| :--- | :--- |
| Successful request | 200 |
| Record validation failed | 422 |
| Record Not Found | 404 |
| Action Conflict | 409 |
| Operational Category delete attempt | 409 |

## Seed Data
* 4 categories (Computing, Optics, Networking, Electronics)
* 8 equipment items spread across all categories with different statuses
* 5 maintenance records spread across at least 3 different equipment items
  
## Business Rules
1. Zero destruction for equipment categories that retain operational items (409).
2. Status verification constraints limit types exclusively.
3. Empty description attributes are forbidden.
4. Validation rule blocks duplicate serial parameters at the model submission layer.

## Curl Examples
Manual confirmation steps utilizing terminal environments can expose JSON arrays dynamically via local server setups.
