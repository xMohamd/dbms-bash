# Database Management System (DBMS) Shell Script Project

## Overview

This project is a simple Database Management System (DBMS) implemented in Bash scripting. The purpose of this DBMS is to allow users to create, connect to, and manage databases, as well as perform operations on tables within the databases.

## Features

- **Database Operations:**

  - Create Database
  - List Databases
  - Connect To Specific Database
  - Drop Database

- **Table Operations:**
  - Create Table
  - List Tables
  - Drop Table
  - Insert into Table
  - Select All From Table
  - Select Record From Table
  - Select From Table
  - Delete From Table
  - Update Table

## Project Structure

The project is organized into the following directories:

- **dbActions:** Contains scripts for performing database-related operations.
- **tbActions:** Contains scripts for performing table-related operations.
- **utils:** Contains utility scripts used across various operations.
- **main.sh:** The main script to execute and navigate through the DBMS functionalities.

## Getting Started

1. **Clone the repository to your local machine:**

   ```bash
   git clone https://github.com/xMohamd/dbms-bash.git
   cd dbms-bash
   ```

2. **Run the main script:**

   On Linux or macOS:

   ```bash
   chmod u+x main.sh
   ./main.sh
   ```

   On Windows:

   - If you are using [Git Bash](https://gitforwindows.org/), open the Git Bash terminal and navigate to the cloned directory. Run:

     ```bash
     chmod u+x main.sh
     ./main.sh
     ```

   - If you have [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install) installed, you can follow the Linux instructions.

3. **Follow the on-screen prompts to interact with the DBMS.**

## Usage

- The main menu provides options to perform various database and table operations.
- Follow the on-screen prompts to input information and execute desired actions.
- Tables are stored as files in the `dbs` directory, and each table has a corresponding metadata file.

## Limitations

- This DBMS is a lightweight script and may not cover advanced database features.
- It currently supports only basic data types and operations.
