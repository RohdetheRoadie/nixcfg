let
  saenger-vm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH0pJyzIk4nzOuPtXZO0IWuZwRWZ2VEp13duX3WqGMZg";
in {
  "secret1.age".publicKeys = [saenger-vm ];
}