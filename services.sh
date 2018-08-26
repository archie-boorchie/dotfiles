#!/bin/bash

# Here we automatically start/enable/disable 
# various sevices. 

# Use kmscon in tty3 
sudo systemctl disable getty@tty3.service
sudo systemctl enable kmsconvt@tty3.service

# Network manager
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

