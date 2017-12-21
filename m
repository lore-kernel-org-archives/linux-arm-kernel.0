From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 21 Dec 2017 23:05:35 +0800
Subject: [PATCH 0/2] Add EHCI/OHCI nodes for V3s and Lichee Pi Zero
Message-ID: <20171221150537.20304-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the PHY dual-route property is added to 4.15-rc, the EHCI/OHCI nodes
are now necessary.

Please apply these patches to 4.15, Thanks!

Icenowy Zheng (2):
  ARM: sun8i: v3s: add EHCI/OHCI0 device nodes
  ARM: sun8i: v3s: enable EHCI/OHCI for Lichee Pi Zero

 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts |  8 ++++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi              | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.14.2
