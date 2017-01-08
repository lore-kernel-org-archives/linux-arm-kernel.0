From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun,  8 Jan 2017 14:30:56 +0100
Subject: [PATCH 0/4] ARM: dts: mt7623: Add initial Geek Force support
Message-ID: <20170108133100.10428-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Andreas F?rber (4):
  Documentation: devicetree: Add vendor prefix for AsiaRF
  Documentation: devicetree: arm: mediatek: Add Geek Force board
  ARM: dts: mt7623: Add Geek Force config
  MAINTAINERS: Extend ARM/Mediatek SoC support section

 Documentation/devicetree/bindings/arm/mediatek.txt |  3 +
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 MAINTAINERS                                        |  2 +
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/mt7623-geekforce.dts             | 77 ++++++++++++++++++++++
 5 files changed, 84 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt7623-geekforce.dts

-- 
2.10.2
