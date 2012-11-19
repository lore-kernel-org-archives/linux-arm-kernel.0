From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 19 Nov 2012 18:47:20 +0100
Subject: [GIT PULL] at91: DT material for 3.8
Message-ID: <50AA70A8.7020204@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is a little update on the DT front for AT91. The biggest part
will come from the pinctrl which is located in Linus Walleij's git tree.

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-for-next-dt

for you to fetch changes up to 824b43968fed4b5a200cfef06129c0470eef306a:

  ARM: at91/dts: evk-pro3: enable watchdog (2012-11-16 15:48:48 +0100)

----------------------------------------------------------------
More DT material for AT91:

- conversion of watchdog to DT
- usart definition for evk-pro3 board

----------------------------------------------------------------
Fabio Porcedda (4):
      ARM: at91: dt: evk-pro3: enable uart0 and uart2
      watchdog: at91sam9_wdt: add device tree support
      ARM: at91/dts: add at91sam9_wdt driver to at91sam926x, at91sam9g45
      ARM: at91/dts: evk-pro3: enable watchdog

 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 15 +++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                       |  6 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi                       |  6 ++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                       |  6 ++++++
 arch/arm/boot/dts/evk-pro3.dts                           | 12 ++++++++++++
 drivers/watchdog/at91sam9_wdt.c                          | 11 +++++++++++
 6 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

Thanks, bye,
-- 
Nicolas Ferre
