#!/bin/bash
curl -sfL https://get.k3s.io | K3S_URL=https://${module.bastion.public_ip}:6443 K3S_TOKEN=mytoken sh -