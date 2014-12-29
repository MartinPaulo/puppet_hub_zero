A set of scripts to install HubZero
===================================

This project is a set of scripts for installing [HubZero](https://hubzero.org) onto a virtual machine
running on the Nectar cloud, using [Heat](https://support.rc.nectar.org.au/docs/heat)

# NB: This is a work in progress! #

To use these scripts you need to have the Heat command line client installed. Instructions for installing and using
the command line tools on the NeCTAR cloud [are found here](https://support.rc.nectar.org.au/docs/installing-command-line-tools).

You also need to know a little bit about [Heat](https://support.rc.nectar.org.au/docs/heat) if you are
going to customize the default paramater values...

Once the command line tools are installed, the following steps will get you up and running:

```bash
# Clone the repository
git clone https://github.com/MartinPaulo/puppet_hub_zero.git

# Copy the environment template in the heat subdirectory, say to a file named 'environment.yaml'
cp heat/environment_template.yaml heat/environment.yaml

# Edit the file and provide any required parameters.
# Also put in replacement values for any of the default parameter values that are not acceptable.
# These parameters and the defaults are described in the heat template, heat/hubzero.yaml
vi heat/environment.yaml

# Launch the heat template
heat stack-create --template-file=heat/hubzero.yaml --environment-file=heat/environment.yaml hubzero_1_3

# wait for a while...
```

The installation will attempt to send email to the address given in the environment template once it is complete.
Typically it will take up to 15 minutes to run through the installation.

Once complete, the passwords and users created by the ldap installation have been written to the file:

```bash
/root/ldap_details.txt
```

If installing version 1.1, once the installation is complete, go to the administrator section of your site
(/administrator), go to Site->Maintenance->LDAP and press the Export Users and Export Groups buttons
in order to export all the CMS users and groups

Tasks still to be done:
- Email needs to be properly configured ( *Check: must not relay email!* )
- Do we need to move the users home directories to the larger mounted transient storage?
- rapture not yet added to the installation
- submit not yet added to the installation
- The DNS entry for the site and any matching records need to be set up manually. Instructions have to be written.

Known issues:
- The LDAP installation on version 1.1 returns an error: this needs investigation. See the open-ldap module for more.
- The maxwell service create template execution seems to be totally arbitrary in terms of its completion times
  (and success). This would appear to be a HubZero Issue
- The email doesn't send mail successfully to all sites, as some sites, such as google,  don't trust it (not surprising).
- The [admin url](https://hubzero.org/wiki/HubAdministrationGuide/Login) doesn't let you log in using the password
  generated by the LDAP program...