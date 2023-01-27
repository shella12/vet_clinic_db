# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
  - [🚀 Live Demo](#live-demo)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
  - [Usage](#usage)
  - [Run tests](#run-tests)
  - [Deployment](#triangular_flag_on_post-deployment)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [❓ FAQ](#faq)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 📖 [vet_clinic database] <a name="about-project"></a>

> **vet_clinic database** is a project that includes database queries to create vet_clinic database.


## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>

<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  </ul>
</details>

<!-- Features -->

### Key Features <a name="key-features"></a>

- **Create tables for databae**
- **Populate tables with sample data**
- **Run relavent queries to fetch data from database**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 💻 Getting Started <a name="getting-started"></a>

This repository includes files with plain SQL that can be used to recreate a database:

- Use [schema.sql](./schema.sql) to create all tables.
- Use [data.sql](./data.sql) to populate tables with sample data.
- Check [queries.sql](./queries.sql) for examples of queries that can be run on a newly created database.

 **Important note: this file might include queries that make changes in the database (e.g., remove records). Use them responsibly!**

### Prerequisites

- Postgresql@14:

To install run:

```sh
 brew install postgresql@14
```

### Setup

Clone this repository to your desired folder:

```sh
  cd my-folder
  git clone git@github.com:shella12/vet_clinic_db.git
```

### Usage

To run the project, start the Postgresql server first, connect with vet_clininc database and execute the following commands on terminal:

```sh
  $ brew services restart postgresql@14
  $ psql postgres

  postgres=# CREATE DATABASE vet_clininc;
  CREATE DATABASE

  postgres=# \c vet_clininc;
  CREATE DATABASE

```

Exit sql by running 

```sh

postgres=# \q

```
Reconnect with database by

```sh

$ psql vet_clinic

```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

- GitHub: [@shella12](https://github.com/shella12)
- Twitter: [@Ayesha Arshad](https://twitter.com/AyeshaA03712974)
- LinkedIn: [Ayesha Arshad](https://www.linkedin.com/in/ayesha-arshad-a690a015a/)

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## ⭐️ Show your support <a name="support"></a>

Give a ⭐️ if you like this project!

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## ❓ FAQ <a name="faq"></a>

- **[Why use this repository app?]**

  - [To create database for vet_clinic]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
