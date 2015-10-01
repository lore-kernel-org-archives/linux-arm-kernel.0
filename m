From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:37 +0200
Subject: [PATCH 00/16] LPC18xx DTS changes for 4.4
Message-ID: <1443732893-17145-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set includes the DTS changes for lpc18xx for v4.4. Mostly
additions of new nodes to lpc18xx.dtsi for drivers that when upstream
during the last cycle and board updates to the Hitex and Embedded
Artists boards.


Ariel D'Alessandro (3):
  ARM: dts: lpc18xx: add watchdog node
  ARM: dts: lpc18xx: add sct pwm node
  ARM: dts: lpc4350-hitex-eval: add i2c0 and devices

Joachim Eastwood (13):
  ARM: dts: lpc18xx: add rgu node
  ARM: dts: lpc18xx: add spifi node
  ARM: dts: lpc18xx: add dmac node
  ARM: dts: lpc18xx: add dmamux node
  ARM: dts: lpc18xx: add dma to ssp0/1
  ARM: dts: lpc18xx: add dma to uart0/1/2/3
  ARM: dts: lpc18xx: add i2c nodes
  ARM: dts: lpc18xx: add resets entry to device nodes
  ARM: dts: lpc4357-ea4357: add spifi and flash device
  ARM: dts: lpc4357-ea4357: add ssp0
  ARM: dts: lpc4357-ea4357: add i2c0 and devices
  ARM: dts: lpc4350-hitex-eval: add spifi and flash device
  ARM: dts: lpc4350-hitex-eval: add joystick, buttons and leds

 arch/arm/boot/dts/lpc18xx.dtsi              | 134 +++++++++++++++++++++
 arch/arm/boot/dts/lpc4350-hitex-eval.dts    | 175 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts |  95 +++++++++++++++
 3 files changed, 404 insertions(+)

-- 
1.8.0
