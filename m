From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Sat, 10 Mar 2018 06:26:01 +0100
Subject: [GIT PULL] ARM: at91: DT for 4.17
Message-ID: <20180310052601.GA6294@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Not much this cycle, mainly changes on the Axentia boards from Peter and
a cleanup from Bartosz.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.17-dt

for you to fetch changes up to 6fa65edf87886f85a18680ed7bdedc15cb810065:

  ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9263ek (2018-02-13 17:15:18 +0100)

----------------------------------------------------------------
AT91 DT for 4.17:

 - use 'atmel' as at24 manufacturer
 - device addition and fixes for axentia boards
 - fix sama5d4 pinctrl compatible

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: dts: at91: sam9rl: Properly assign copyright

Bartosz Golaszewski (5):
      ARM: dts: at91: use 'atmel' as at24 manufacturer for sama5d34ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9260ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9g20ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91-sama5d2_ptc_ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9263ek

Peter Rosin (5):
      ARM: dts: at91: nattis: use the correct compatible for the eeprom
      ARM: dts: at91: tse850: use the correct compatible for the eeprom
      ARM: dts: at91: nattis: use up-to-date mtd partitions
      ARM: dts: at91: nattis: add lvds-encoder
      ARM: dts: at91: tse850: make the sound dai cell count explicit

Santiago Esteban (1):
      ARM: dts: at91: sama5d4: fix pinctrl compatible string

 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 60 +++++++++++++++++++++--------
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   |  2 +-
 arch/arm/boot/dts/at91-tse850-3.dts         |  3 +-
 arch/arm/boot/dts/at91sam9260ek.dts         |  2 +-
 arch/arm/boot/dts/at91sam9263ek.dts         |  2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi           |  3 +-
 arch/arm/boot/dts/at91sam9rlek.dts          |  3 +-
 arch/arm/boot/dts/sama5d34ek.dts            |  2 +-
 arch/arm/boot/dts/sama5d4.dtsi              |  2 +-
 10 files changed, 57 insertions(+), 24 deletions(-)

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
