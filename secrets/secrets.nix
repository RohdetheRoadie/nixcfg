let
  saenger-vm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH0pJyzIk4nzOuPtXZO0IWuZwRWZ2VEp13duX3WqGMZg";
  roadie_saenger-iron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID+eJBSgmo47+k0fsMoU6s2/cVq2KUOTzIlz1M2Vvs5C";
in {
  "secret1.age".publicKeys = [ saenger-vm ];
  "roadie-secrets.age".publicKeys = [ saenger-vm roadie_saenger-iron];
}