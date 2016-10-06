From: paweljarosz3691@gmail.com (=?us-ascii?B?PT9VVEYtOD9xP1Bhd2U9QzU9ODI9MjBKYXJvc3o/PQ==?=)
Date: Thu, 6 Oct 2016 18:22:09 +0200
Subject: [PATCH 0/3] Add MK808 RK3066 device
Message-ID: <cover.1475764778.git.paweljarosz3691@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for Rikomagic MK808 v1 device with RK901 wifi.

It is hdmi stick with two usb ports(host and otg), sdmmc, wifi and uart
onboard.

It is RK3066 based.

Pawe? Jarosz (3):
  ARM: dts: rockchip: Enable build of rk3066 MK808 dts
  devicetree: Add vendor prefix for Rikomagic
  ARM: dts: rockchip: Add rk3066 MK808 board devicetree description file

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3066a-mk808.dts                | 184 +++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3066a-mk808.dts

-- 
2.7.4
