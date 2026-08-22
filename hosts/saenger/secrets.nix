{
  age.secrets = {
    secret1 = {
      file = ../../secrets/secret1.age;
      # owner = "roadie";
      # group = "roadie";
      # mode = "0400";
      # path = "/home/roadie/.secret1"; #To provide secret to destination
    };
    roadie-secrets = {
      file = ../../secrets/roadie-secrets.age;
      owner = "roadie";
    };
  };
  ## Chad says the below didn't work because of the bare secrets keyword
  # age = {
  #   secrets = {
  #     secret1 = {
  #       file = ../../secrets/secret1.age;
  #     };
  #   };
  # };
}