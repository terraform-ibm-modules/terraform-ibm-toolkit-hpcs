#!/bin/sh
ibmcloud tke cryptounits | grep -e "SERVICE INSTANCE:" | grep -n $1 | cut -f1 -d: > temp.txt