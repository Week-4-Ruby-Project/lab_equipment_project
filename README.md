# lab_equipment_project
## 1. Project Description
[cite_start]The Lab Equipment API is a full-stack backend application designed to streamline and organize department tracking for various physical assets such as laptops, microscopes, routers, and processing kits [cite: 107-111]. [cite_start]Replacing inefficient manual whiteboards and chat groups, this system serves as a single source of truth for checking asset availability, tracking operational status, and keeping a comprehensive chronological history of all professional maintenance work [cite: 109-113]. [cite_start]The application strictly implements automated database-level and model-level constraints to prevent malformed records and enforce strict institutional data rules [cite: 114-115].

## 2. Setup Instructions
[cite_start]To set up and run this project locally from scratch, execute the following commands in your terminal [cite: 23-27]:

```bash
# Clone the repository from the organization
git clone <repo-url>

# Navigate into the project directory
cd lab_equipment_project

# Install the required dependencies and gems
bundle install

# Create the database, run migrations, and populate seed data
bin/rails db:create db:migrate db:seed

# Start the local development server
bin/rails server
