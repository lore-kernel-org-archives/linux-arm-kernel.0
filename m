From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 15 May 2017 03:11:28 +0200
Subject: [PATCH 0/2] arm64: meson-gxbb: NanoPi K2 enablement
Message-ID: <20170515011130.29265-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series adds initial support for the Amlogic S905 based
FriendlyARM NanoPi K2 SBC.

Tested with mainline U-Boot.

Regards,
Andreas

Cc: devicetree at vger.kernel.org
Cc: techsupport at friendlyarm.com

Andreas F?rber (2):
  dt-bindings: arm: amlogic: Add NanoPi K2
  arm64: dts: amlogic: Add NanoPi K2

 Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      | 152 +++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts

-- 
2.12.0
