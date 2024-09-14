# Project 2 : Scaffolding Small Express Server + Mongo

Watch video: https://youtu.be/aTuuBpXfno8

### 1. Get DigitalOcean Token
- Visit the [DigitalOcean website](https://cloud.digitalocean.com/) and log in.
- Navigate to the API section to generate a **Personal Access Token**. Copy the token for later use.

### 2. Create Terraform Variables File
- Navigate to the `tf` folder.
- Copy the example file to create your actual variables file:
  
  ```bash
  cp terraform.tfvars.example terraform.tfvars
  ```

- Open `tf/terraform.tfvars` and replace `do_token` with the token obtained from the DigitalOcean website:
  ```ini
  do_token = "your-digitalocean-token"
  ```

### 3. Add or Create an SSH Key
- If you don’t already have an SSH key, create one:

  ```bash
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f key_name
  ```

- Copy the public key:

  ```bash
  cat key_name.pub
  ```

- In `tf/main.tf`, insert your public key in the `digitalocean_ssh_key` resource:

  ```hcl
  resource "digitalocean_ssh_key" "project_2_key" {
    name       = "project_2_key"
    public_key = "your-public-key-here"
  }
  ```

### 4. Provision the VM Using Terraform
- Initialize Terraform in the `tf` directory:

  ```bash
  terraform init
  ```

- Run Terraform to provision the resources:

  ```bash
  terraform apply
  ```

- After provisioning, Terraform will output the **IPv4 address** of the newly created VM. Copy this address for later.

### 5. Update Ansible Hosts File
- Navigate to the `ansible` folder.
- Edit the `host.ini` file:
- Replace the placeholder with the IPv4 address of the VM provided by Terraform:

  ```ini
  [project-2-vm]
  project-2-vm ansible_host=ipv4.here ansible_user=root ansible_ssh_private_key_file=/path/to/your-key
  ```

### 6. Ping the VM Using Ansible
- Ensure the VM is up and has Python installed by pinging it via Ansible:

  ```bash
  ansible -i host.ini project-2-vm -m ping
  ```

  If the ping succeeds, the VM is reachable.

### 7. Run Ansible Playbook for Setup
- Run the initial setup playbook:

  ```bash
  ansible-playbook -i host.ini setup.yml
  ```

### 8. Run Ansible Playbook for Docker Installation
- Install Docker and any required software by running the Docker playbook:

  ```bash
  ansible-playbook -i host.ini docker.yml
  ```

### 9. Access the Software
- Once the Docker playbook finishes, the software will be running on **port 4000**.
- Open your browser and navigate to the **public IPv4** of the VM on **port 4000**:

  ```bash
  http://your-vm-ipv4:4000
  ```

You should now be able to access the [running software: https://github.com/tfd-ed/tw-clone-api](https://github.com/tfd-ed/tw-clone-api).