#!/bin/bash

echo "sync data base assets to main assets..."
mkdir -p assets/main
cp -r assets/db-assets/* assets/main/
sleep 0.2

echo "sync data base config to main config..."
cp -r include/configs/database/* include/configs/main/
sleep 0.2