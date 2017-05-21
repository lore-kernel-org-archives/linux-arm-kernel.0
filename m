From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 21 May 2017 20:51:03 +0200
Subject: [PATCH v2 0/2] arm64: meson-gxbb: NanoPi K2 enablement
Message-ID: <20170521185105.23448-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series adds initial support for the Amlogic S905 based
FriendlyARM NanoPi K2 SBC.

Tested with mainline U-Boot.

v2 adds USB and Wifi among others.

Regards,
Andreas

Cc: devicetree at vger.kernel.org
Cc: techsupport at friendlyarm.com

Andreas F?rber (2):
  dt-bindings: arm: amlogic: Add NanoPi K2
  arm64: dts: amlogic: Add NanoPi K2

 Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      | 291 +++++++++++++++++++++
 3 files changed, 293 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts

-- 
2.12.0
