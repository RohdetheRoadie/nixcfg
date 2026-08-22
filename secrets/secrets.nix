let
  # Systems
  saenger-vm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH0pJyzIk4nzOuPtXZO0IWuZwRWZ2VEp13duX3WqGMZg";
  saenger = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVVCvbgd5ko8Pm5WdDW7LRni46lXd+kwgzoivtXd9x7";

  systems = [saenger-vm saenger];
  
  # Users
  roadie_saenger-iron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID+eJBSgmo47+k0fsMoU6s2/cVq2KUOTzIlz1M2Vvs5C";
  
  users = [roadie_saenger-iron];

in {
  "secret1.age".publicKeys = [ saenger-vm roadie_saenger-iron saenger];
  "roadie-secrets.age".publicKeys = users ++ systems;
}

# to make secret, first add ssh public key in let, and key file in in
# Then nix run github:ryantm/agenix -- -e $SECRET.age
# secret format is " $NAME = $VALUE"

# CREATE secret
# nix run github:ryantm/agenix -- -e secret1.age

# REKEY (when you add a new key for secret access)
# cd secrets/
# nix run github:ryantm/agenix -- --rekey -i /home/roadie/.ssh/saenger_iron (PATH TO A VALID PRIVATE KEY)