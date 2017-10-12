#!/bin/bash

mount.cifs -o ro,remount,username=username,dir_mode=0755,file_mode=0740 //my-pc/toPlex /net/my-pc
