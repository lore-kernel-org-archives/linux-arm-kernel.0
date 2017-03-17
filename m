From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 17 Mar 2017 23:43:40 +0800
Subject: [PATCH 0/3] Basical Lichee Pi Zero with Dock support
Message-ID: <20170317154343.39921-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lichee Pi Zero have an official dock, which makes use of all stamp hole pins.

Some extra functionalities are availble via the dock, e.g. an extra MMC slot
and some keys connected to LRADC.

This patchset adds the support of these two features of the dock.

Icenowy Zheng (3):
  ARM: sun8i: v3s: add LRADC device node
  ARM: dts: sun8i: add pinmux for V3s mmc1
  ARM: dts: sun8i: add device tree for Lichee Pi Zero with Dock

 arch/arm/boot/dts/Makefile                         |  3 +-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 98 ++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   | 15 ++++
 3 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts

-- 
2.12.0
