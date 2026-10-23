#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.86.1/g' package/base-files/files/bin/config_generate

# Modify default theme
sed -i 's/luci-theme-bootstrap/luci-theme-aurora/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/ImmortalWrt/FastRhino/g' package/base-files/files/bin/config_generate
# 互换 LAN WAN（eth0、eth1）刷机首次开机自动执行
cat > $BUILD_DIR/etc/uci-defaults/99-swap-lan-wan <<'EOF'
#!/bin/sh
uci set network.lan.device='eth1'
uci set network.wan.device='eth0'
uci set network.wan6.device='eth0'
uci commit network
EOF
chmod +x $BUILD_DIR/etc/uci-defaults/99-swap-lan-wan
