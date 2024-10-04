{ pkgs, config, inputs, ... }:
{
  environment.etc."nextcloud-admin-pass".text = "Placeholder";
  services.nextcloud = {
    enable = true;
    hostName = "cloud.local";
    package = pkgs.nextcloud29;
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = "etc/nextcloud-admin-pass";
    };
  };
}
