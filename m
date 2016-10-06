From: paweljarosz3691@gmail.com (=?utf-8?B?UGF3ZcWC?= Jarosz)
Date: Thu, 6 Oct 2016 19:37:31 +0200
Subject: [PATCH v2 0/2] Add MK808 RK3066 device
Message-ID: <cover.1475774981.git.paweljarosz3691@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
 arch/arm/boot/dts/rk3066a-mk808.dts                | 184 +++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3066a-mk808.dts

-- 
2.7.4
