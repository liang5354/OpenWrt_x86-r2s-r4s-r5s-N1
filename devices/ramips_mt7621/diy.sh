#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))


sed -i "s/DEVICE_MODEL := HC5962$/DEVICE_MODEL := HC5962 \/ B70/" target/linux/ramips/image/mt7621.mk

sh -c "curl -sfL https://github.com/openwrt/openwrt/commit/2e6d19ee32399e37c7545aefc57d41541a406d55.patch | patch -d './' -p1 --forward" || true

# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

#修改root密码为空
sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings

# Modify default theme修改默认主题
rm -rf package/lean/luci-theme-bootstrap
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
