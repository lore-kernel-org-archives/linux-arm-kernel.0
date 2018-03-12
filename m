From: harald@ccbib.org (Harald Geyer)
Date: Mon, 12 Mar 2018 16:10:45 +0000
Subject: arm64: allwinner: Add support for TERES I laptop
Message-ID: <20180312161050.7647-1-harald@ccbib.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the TERES I open hardware laptop produced
by olimex. With these patches and a bootloader capable of setting up
simple framebuffer the laptop is quite useable.

Patches 1-4 add some pin descriptions and devices in the A64 dtsi, which
are useful to have on the teres.
Patch 5 finally adds the board dts itself.

best regards,
Harald

Harald Geyer (5):
  arm64: dts: allwinner: a64: Add i2c0 pins
  arm64: dts: allwinner: a64: Add watchdog
  arm64: dts: allwinner: a64: add simplefb for A64 SoC
  arm64: dts: allwinner: a64: Add pwm device
  arm64: allwinner: a64: Add support for TERES I laptop

 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 308 +++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  44 +++
 3 files changed, 353 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts

-- 
2.11.0
