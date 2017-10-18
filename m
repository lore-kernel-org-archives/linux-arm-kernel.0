From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 18 Oct 2017 21:06:23 +0800
Subject: [PATCH v2 0/5] Allwinner R40 USB host support (DT part)
Message-ID: <20171018130628.11298-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the USB host ports on Allwiner R40, and
enable them on Banana Pi M2 Ultra and Berry boards.

The first patch adds USB PHY and EHCI/OHCI nodes to the R40 DTSI.

The second and third patch adds 5V regulator for the two boards, and
the fourth and fifth patch finally adds USB host ports support.

Icenowy Zheng (5):
  ARM: sun8i: r40: add USB host port nodes for R40
  ARM: sun8i: r40: add 5V regulator for Banana Pi M2 Ultra
  ARM: sun8i: v40: add 5V regulator for Banana Pi M2 Berry
  ARM: sun8i: r40: enable USB host for Banana Pi M2 Ultra
  ARM: sun8i: v40: enable USB host ports for Banana Pi M2 Berry

 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 31 ++++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi                  | 72 +++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 22 +++++++
 3 files changed, 125 insertions(+)

-- 
2.13.6
