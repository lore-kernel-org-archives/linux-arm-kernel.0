From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 28 May 2018 22:05:40 +0200
Subject: [GIT PULL] pxa-dt for v4.18
Message-ID: <878t83tujv.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.18 device-tree, with a couple fixes from
Daniel for pxa3xx.

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-dt-4.18

for you to fetch changes up to 07c8d21d08a589bc01238fe09a6edb54d24f3da0:

  ARM: dts: pxa3xx: fix MMC clocks (2018-05-25 23:16:18 +0200)

----------------------------------------------------------------
This device-tree pxa update brings :
 - fix pxa3xx MMC bindings
 - add pxa3xx GPIOs
 - add pxa3xx missing pin controller

----------------------------------------------------------------
Daniel Mack (3):
      ARM: pxa: dts: add gpio-ranges to gpio controller
      ARM: pxa: dts: add pin definitions for extended GPIOs
      ARM: dts: pxa3xx: fix MMC clocks

 arch/arm/boot/dts/pxa3xx.dtsi | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
Robert
