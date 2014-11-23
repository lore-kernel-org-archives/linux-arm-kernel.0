From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Sun, 23 Nov 2014 11:41:58 +0200
Subject: [PATCH 0/4] ARM: dts: sbc-t3x: add audio and TV out support
Message-ID: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for more SBC-T3x single board computers features:

* Audio on CM-T3x30
* TV out on CM-T3x

This patch set adds missing I2C1 pinmux required for CM-T3x EEPROM and 
CM-T3x30 audio support.

Dmitry Lifshitz (4):
  ARM: dts: cm-t3x: add I2C1 pinmux
  ARM: dts: cm-t3x: add TV out support
  ARM: dts: sbc-t3x: add TV out display alias
  ARM: dts: sbc-t3x30: add audio support

 arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   48 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |   18 ++++++++++++
 arch/arm/boot/dts/omap3-sb-t35.dtsi   |   16 +++++++++++
 arch/arm/boot/dts/omap3-sbc-t3517.dts |    1 +
 arch/arm/boot/dts/omap3-sbc-t3530.dts |    1 +
 arch/arm/boot/dts/omap3-sbc-t3730.dts |    1 +
 6 files changed, 85 insertions(+), 0 deletions(-)

-- 
1.7.5.4
