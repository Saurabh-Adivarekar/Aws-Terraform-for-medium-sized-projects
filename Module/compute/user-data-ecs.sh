#!/bin/bash
sudo amazon-linux-extras disable docker
sudo amazon-linux-extras install -y ecs
systemctl enable --now --no-block ecs.service
echo ECS_CLUSTER='template-ecs-cluster' >> /etc/ecs/ecs.config