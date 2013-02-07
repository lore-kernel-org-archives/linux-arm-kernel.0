From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 7 Feb 2013 17:03:23 +0100
Subject: [GIT PULL] at91: Device Tree related material for 3.9
Message-ID: <5113D04B.2060101@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is a pull request for AT91 Device Tree material. It is pretty small and
mostly related to at91rm9200 work done by Joachim.

This one can go on top of the GIT PULL request that I sent two days ago:
"[GIT PULL] at91: fixes for 3.9-rc1". But actually it is not related...


The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-dt

for you to fetch changes up to ce3b2630fd4737a3f9aa9119d40647a9ac7baa38:

  ARM: at91: add EMAC bindings to RM9200 DT (2013-02-07 16:40:09 +0100)

----------------------------------------------------------------
Update to DT files for AT91:
- adding the watchdog to Animeo IP board
- some more DT support for at91rm9200 peripherals

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: Animeo IP: enable watchdog support

Joachim Eastwood (3):
      ARM: at91: add MMC bindings to RM9200 DT
      ARM: at91: add SSC bindings to RM9200 DT
      ARM: at91: add EMAC bindings to RM9200 DT

 arch/arm/boot/dts/animeo_ip.dts    |   4 +
 arch/arm/boot/dts/at91rm9200.dtsi  | 158 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91rm9200ek.dts |   5 ++
 arch/arm/mach-at91/at91rm9200.c    |   2 +
 4 files changed, 169 insertions(+)


Thanks best regards,
-- 
Nicolas Ferre
