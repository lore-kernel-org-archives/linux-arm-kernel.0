From: paweljarosz3691@gmail.com (=?utf-8?B?UGF3ZcWC?= Jarosz)
Date: Sat, 8 Oct 2016 22:21:47 +0200
Subject: [PATCH v3 0/2] Add MK808 RK3066 device
Message-ID: <cover.1475957884.git.paweljarosz3691@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MK808 RK3066 device

This patchset adds support for Rikomagic MK808 v1 device with RK901 wifi.

It is hdmi stick with two usb ports(host and otg), sdmmc, wifi and uart
onboard.

It is RK3066 based.

Pawe? Jarosz (2):
  devicetree: Add vendor prefix for Rikomagic
  ARM: dts: rockchip: Add rk3066 MK808 board

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3066a-mk808.dts                | 196 +++++++++++++++++++++
 4 files changed, 202 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3066a-mk808.dts

-- 
2.7.4
