FROM openjdk:11-jre-slim

####################################################################################
# INSTALL MICROSOFT ODBC DRIVER FOR SQL SERVER
####################################################################################
SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# Update apt-get
RUN apt-get update
RUN apt-get install -y curl

RUN if ! [[ "8 9 10 11 12" == *"$(grep VERSION_ID /etc/os-release | cut -d '"' -f 2 | cut -d '.' -f 1)"* ]]; \
then \
    echo "Debian $(grep VERSION_ID /etc/os-release | cut -d '"' -f 2 | cut -d '.' -f 1) is not currently supported."; \
    exit; \
fi  # Terminate the docker build if the debian version is outside of "8 9 10 11 12"

RUN curl -sSL -O https://packages.microsoft.com/config/debian/$(grep VERSION_ID /etc/os-release | cut -d '"' -f 2 | cut -d '.' -f 1)/packages-microsoft-prod.deb  # Download the package to configure the Microsoft repo
RUN dpkg -i packages-microsoft-prod.deb  # Install the package
RUN rm packages-microsoft-prod.deb  # Delete the file
RUN apt-get update  # Update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18  # Install Microsoft SQL ODBC Driver

####################################################################################
# INSTALL PYTHON DEPENDENCCIES
####################################################################################
# Update `apt-get` and install `python`
RUN apt-get install -y python3 python3-pip git

# Install python libraries
COPY configs/requirements-dev.txt .
RUN pip install -r requirements-dev.txt

COPY configs/no-deps-requirements.txt .
RUN pip install --no-deps -r no-deps-requirements.txt
