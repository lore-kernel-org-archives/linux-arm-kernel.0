From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 13 Jun 2016 12:15:30 +0200
Subject: [PATCH] ARM: sun8i: Add Parrot Board DTS
Message-ID: <1465812931-22824-1-git-send-email-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Parrot Board is an evaluation board with an Allwinner R16 (assumed
to be close to an Allwinner A33), 4GB of NAND, 512MB of RAM, USB host
and OTG, a WiFi/Bluetooth combo chip, a micro SD Card reader, 2
controllable buttons, an LVDS port with separated backlight and
capacitive touch panel ports, an audio/microphone jack, a camera CSI
port, 2 sets of 22 GPIOs and an accelerometer.

This patch requires patches named "[v3] regulator: axp20x: Add support
for the (external) drivebus regulator" and "[PATCH 3/4] ARM: dts:
axp22x.dtsi: Add reg_drivebus node" from Hans de Goede or the micro USB
port would not be powered.

Quentin Schulz (1):
  ARM: sun8i: Add Parrot Board DTS

 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/sun8i-r16-parrot.dts | 333 +++++++++++++++++++++++++++++++++
 2 files changed, 334 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-r16-parrot.dts

-- 
2.5.0
