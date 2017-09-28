From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 28 Sep 2017 17:25:40 +0800
Subject: [PATCH v2 0/3] Basical device tree parts for Allwinner R40 SoC
Message-ID: <20170928092543.45648-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds basical device tree parts for the Allwinner R40 SoC
and two boards feature this SoC -- Banana Pi M2 Ultra and Berry (The
BPi M2 Berry board uses V40 SoC, which is just a renamed R40).

Chen-Yu Tsai (2):
  ARM: dts: sun8i: Add basic dtsi file for Allwinner R40
  ARM: dts: sun8i: Add board dts file for Banana Pi M2 Ultra

Icenowy Zheng (1):
  ARM: dts: sun8i: Add board dts file for Banana Pi M2 Berry

 arch/arm/boot/dts/Makefile                        |   4 +-
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 177 ++++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi                  | 407 ++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 164 +++++++++
 4 files changed, 751 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r40.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts

-- 
2.13.5
