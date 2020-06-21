# nVis Automation

## Why
Examining our experiences in past CPTC competitions, we have spent a considerable amount of time doing scanning and information gathering, and then writing it on a whiteboard, to the tune of at least an hour or two before all hosts are scanned. This is a collosal waste of time. Delegating subnets and making sure that everyone is running the correct flags is a serious headache. 

This repository presents the solution to these problems.

## What
This repository contains several bash scripts: setup scripts for `docker` and `docker-compose` depending on the OS (debian or ubuntu), and a script to automate the setup and deployment of the `nVis` platform originally developed by Menn1s. In order to deploy this platform, run the appropriate setup script for your operating system with `sudo`, and then run the `nvis-install.sh` script to set up and run the nVis installation. 

Note that this pulls and uses a custom fork of `nVis` for extensability and ongoing development (there are numerous improvements planned) from https://github.com/mustangsecurity/nVis . 

TL;DR: this repository contains tools for automating the setup and installation of the nVis automation platform.

## How
```bash
sudo ./debian-docker-setup.sh # IF DEBIAN
sudo ./ubuntu-docker-setup.sh # IF UBUNTU
sudo ./nvis-install.sh        # INSTALL NVIS
```

Automation scripts developed by Kyle Mistele - github/k-mistele twitter/@0xBlackl1ght