# Databricks Local Project

## Getting Started

### Prerequisites

Ensure the following tools are installed before starting the project:

- PyCharm Community Edition
- DBeaver Community
- Docker
- JDK 11
- Python 3.9.6

### Installation

1. **Install JDK 11**
   
   - **Windows:** Download and install from [Oracle’s JDK download page](https://www.oracle.com/java/technologies/downloads/?er=221886#java11-windows).
   - **Mac:** Run the following command:
   
      ```bash
      brew install openjdk@11
      ```
     
   - Verify installation:
   
      ```bash
      java --version
      ```

2. **Install Python 3.9.6**

   - **Windows:** Download and install from [Python.org](https://www.python.org/ftp/python/3.9.6/python-3.9.6-amd64.exe)
   - **Mac:** Use `pyenv` to manage Python versions:
   
      ```bash
      brew install pyenv
      pyenv install 3.9.6
      pyenv global 3.9.6
      ```
     
   - Verify installation:
   
      ```bash
      python3 --version
      ```
     
3. **Restart Your Computer**

    Restart your computer to ensure that the installations of Java and Python are recognized system-wide.

4. **Clone the repository:**

   Clone the project repository and navigate to the project directory:

   ```bash
   git clone https://github.com/alghofari/databricks-local.git
   cd databricks-local
   ```

5. **Open the Project in PyCharm and Set Up Python Interpreter**
    
    - Open the `databricks-local` directory in PyCharm.
    - Go to `File > Settings` (or `PyCharm > Settings` on Mac) and navigate to `Project: databricks-local > Python Interpreter`.
    - Set the Python interpreter to Python **3.9.6**.
    - Ensure that a virtual environment (`venv`) is created. If not, create one by selecting **Add Interpreter > New Virtualenv Environment** and choosing **Python 3.9.6** as the base interpreter.

6. **Install required Python packages:**
   
   - For general users, install dependencies listed in the `requirements-dev.txt` file:

     ```bash
     pip install -r configs/requirements-dev.txt
     pip install --no-deps -r configs/no-deps-requirements.txt
     ```
     
   - For **Apple Silicon Mac** users, run the following commands to set library paths before installing packages:

     ```bash
     brew install freetds
     export LDFLAGS="-L/opt/homebrew/opt/freetds/lib"
     export CPPFLAGS="-I/opt/homebrew/opt/freetds/include"
     pip install -r configs/requirements-dev.txt
     pip install --no-deps -r configs/no-deps-requirements.txt
     ```

7. **Set up Docker:**

   - For the initial setup, comment out the following line in `docker-compose.yml`: `IS_RESUME: "true"`.
   - Start the Docker containers:
   
      ```bash
     docker-compose up -d
      ```
   
   - For subsequent runs, uncomment `IS_RESUME: "true"` in the `docker-compose.yml` file.

8. **Verify Containers are Running**

   Ensure the following containers are up and running:
   
   - `hive-metastore`
   - `minio`
   - `postgres`
   - `trino`
   
   To check, run the following command:

   ```bash
   docker ps
   ```
   
   **Note:** You can ignore `minio-client` and `mssql-client` if they are not running.

9. **Check MinIO Setup**
    - Open http://localhost:9001 in your browser.
    - Log in using the following credentials:
      - **Username:** `minioadmin`
      - **Password:** `minioadmin`
      - Verify that the `hive` and `staging` buckets are present.
    
    **Troubleshooting:** If the MinIO web console doesn't load, you can't log in, or the `hive` and `staging` buckets are missing, check the MinIO container logs for errors:

    ```bash
    docker logs <minio-container-name>
    ```

10. **Verify Schemas in Trino with DBeaver**

    To ensure the `bronze`, `silver`, and `gold` schemas are created in Trino, follow these steps:
    - Open **DBeaver**.
    - Create a new connection and select **Trino** as the database type.
    - Configure the connection with the following details:
      - **Host:** `localhost`
      - **Port:** `8080`
      - **Username:** `trino`
    - Click **Test Connection** to verify the connection, then select **OK**.
      Once connected, expand the **didx_catalog** database in the left panel and check that the `bronze`, `silver`, and `gold` schemas are present.
