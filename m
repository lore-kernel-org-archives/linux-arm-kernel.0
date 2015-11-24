From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Tue, 24 Nov 2015 16:02:07 +0200
Subject: [PATCH v2 0/6] ARM: OMAP2+: dts: cm-t335: initial support
In-Reply-To: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for CompuLab cm-t335 module based on AM335X SoC.

CM-T335 is a tiny computer-on-module (CoM) / system-on-module (SoM)
The module is built around the Texas Instruments Sitara AM3352/4
system-on-chip.

The CPU is supplemented with up-to 512MB DDR3 and up-to 1GB of on-board
NAND storage, WiFi connected to SPI, Bluetooth, Analog audio, Gigabit
Ethernet, CAN bus.

[v1 -> v2: integrate AM33XX_IOPAD macro in pinmux definitions ]
Ilya Ledvich (6):
  ARM: OMAP2+: dts: cm-t335: add initial support
  ARM: OMAP2+: dts: cm-t335: add basic support for I2C
  ARM: OMAP2+: dts: cm-t335: add support for NAND flash
  ARM: OMAP2+: dts: cm-t335: add support for MMC
  ARM: OMAP2+: dts: cm-t335: add support for network device
  ARM: OMAP2+: dts: cm-t335: add support for PWM backlight

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   7 +-
 arch/arm/boot/dts/am335x-cm-t335.dts               | 348 +++++++++++++++++++++
 3 files changed, 355 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-cm-t335.dts

-- 
2.5.0
