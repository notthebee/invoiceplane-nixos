# invoiceplane-nixos

Add the repository to your flake.nix:

```nix
{
    inputs = {
        invoiceplane = {
          url = "git+file:///Users/notthebee/Documents/Software/invoiceplane-nixos";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    }
}
```

Add the nixosModule to your NixOS configuration:

```nix
modules = [
    self.inputs.invoiceplane.nixosModules.default
];
```

Configure the invoiceplane-beta service:

```nix
services.invoiceplane-beta = {
    sites."invoice.example.com = {
        settings = {
            DISABLE_SETUP = true;
            SETUP_COMPLETED = true;
            IP_URL = "https://invoice.example.com";
        };
    };
};
```
