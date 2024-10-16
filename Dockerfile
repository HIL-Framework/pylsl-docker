# Use Ubuntu as the base image
FROM pytorch/pytorch:latest

# Install necessary packages for LSL
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    sudo

# # Create a non-root user
# RUN useradd -m -s /bin/bash user
    

# Create a non-root user
RUN useradd -m -s /bin/bash user
RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


RUN conda install -c conda-forge liblsl
COPY requirements.txt /home/user/requirements.txt



# Switch to the non-root user
USER user
WORKDIR /home/user

# Install liblsl using conda
RUN conda install -y -c conda-forge liblsl

# Install pylsl
RUN pip install pylsl

# Set up environment variables for liblsl
RUN echo 'export LSLROOT=$(dirname $(dirname $(which conda)))/lib' >> ~/.bashrc && \
    echo 'export LD_LIBRARY_PATH=$LSLROOT:$LD_LIBRARY_PATH' >> ~/.bashrc && \
    echo 'export PYLSL_LIB=$LSLROOT/liblsl.so' >> ~/.bashrc

# Source the bashrc in the entrypoint to ensure environment variables are set
ENTRYPOINT ["/bin/bash", "-c", "source ~/.bashrc && /bin/bash"]