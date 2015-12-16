From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 Dec 2015 11:14:16 +0100
Subject: [GIT PULL] at91: dt for 4.5 #1
Message-ID: <1450260856-1375-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is the first PR for AT91 DT material targeted to 4.5. The main part is the
addition for the new DENX platform. Other things are simply basic fixes and
updates.

Thanks, best regards,

The following changes since commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8:

  Linux 4.4-rc3 (2015-11-29 18:58:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt

for you to fetch changes up to 0a804b5729bb0021e63662b772db0f52de653056:

  ARM: at91/dt: sama5d2 Xplained: pmic needs a specific sda hold time (2015-12-15 12:23:32 +0100)

----------------------------------------------------------------
First batch of DT changes for 4.5:
- addition of nodes for sama5d2 & sama5d4
- some fixes for i2c hold time, compatible stings
- addition of a new patform by DENX: the MA5D4 SoM and EVK

----------------------------------------------------------------
Ludovic Desroches (2):
      ARM: at91/dt: sama5d4: update i2c compatible string
      ARM: at91/dt: sama5d2 Xplained: pmic needs a specific sda hold time

Marek Vasut (3):
      ARM: at91/dt: sama5d4: Fix mmc0 pinmux comments
      ARM: at91/dt: sama5d4: Add pinmux for 8-bit MMC0 bus
      ARM: at91/dt: sama5d4: Add support for DENX MA5D4 SoM and EVK

Nicolas Ferre (1):
      ARM: at91/dt: sama5d4 master clock can run at 200MHz now

Wenyou Yang (1):
      ARM: at91/dt: sama5d2: add watchdog node

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |   5 +
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi   | 127 +++++++++++++++++++++
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts | 170 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              |   7 ++
 arch/arm/boot/dts/sama5d4.dtsi              |  26 +++--
 6 files changed, 327 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
 create mode 100644 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts

-- 
Nicolas Ferre
