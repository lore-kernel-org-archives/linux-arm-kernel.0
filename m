From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 22 Oct 2017 21:58:20 +0200
Subject: [GIT PULL] ARM: at91: DT for 4.15
Message-ID: <20171022195820.hxpzeunexwao26l2@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ardn, Olof,

As usual, the bulk of our changes are in device trees, this time in the
fairly recent sama5d27_som1_ek.

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.15-dt

for you to fetch changes up to 854106bc625a73b251ef7de2d5b49847d53041c2:

  ARM: dts: at91: at91sam9x5ek: use DMA for USART0 (2017-10-10 15:26:20 +0200)

----------------------------------------------------------------
DT for 4.15

 - sama5d2 xplained: add charger and SD card power supply
 - sama5d27_som1_ek: many adjustments
 - at91sam9x25ek: add pwm0 and can1

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: dts: at91: usb_a9g20: fix rtc node

Claudiu Beznea (4):
      ARM: dts: at91: sama5d27_som1_ek: add disabled status
      ARM: dts: at91: sama5d27_som1_ek: enable i2c2
      ARM: dts: at91: sama5d27_som1_ek: add pinmuxing for pwm0
      ARM: dts: at91: sama5d2_xplained: add pinmuxing for pwm0

Ludovic Desroches (4):
      ARM: dts: at91: sama5d27_som1_ek: update serial aliases
      ARM: dts: at91: sama5d27_som1_ek: set USER button as a wakeup source
      ARM: dts: at91: sama5d27_som1_ek: add aliases for i2c
      ARM: dts: at91: sama5d2_xplained: set PB_USER as wakeup source

Nicolas Ferre (6):
      ARM: dts: at91: sama5d27_som1_ek: remove not connected CAN0
      ARM: dts: at91: sama5d27_som1_ek: remove pull-up on SD/MMC lines
      ARM: dts: at91: sama5d2_xplained: remove pull-up on SD/MMC lines
      ARM: dts: at91: at91sam9x25ek: add CAN1 interface
      ARM: dts: at91: at91sam9x25ek: add pwm0
      ARM: dts: at91: at91sam9x5ek: use DMA for USART0

Romain Izard (1):
      ARM: dts: at91: sama5d2 Xplained: Describe the SD card power supply

Wenyou Yang (1):
      ARM: dts: at91: sama5d2_xplained: Add charger node

 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 46 ++++++++++++++---------------
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 41 +++++++++++++++++--------
 arch/arm/boot/dts/at91sam9x25ek.dts         | 10 +++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |  2 ++
 arch/arm/boot/dts/usb_a9g20_common.dtsi     |  4 +--
 5 files changed, 66 insertions(+), 37 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
