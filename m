From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Apr 2017 18:35:57 +0200
Subject: [GIT PULL] ARM: at91: DT for 4.12
Message-ID: <20170410163557.qocx3bvz5s5gcnkw@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is the AT91 DT pull request for 4.12.

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.12-dt

for you to fetch changes up to 4b8dd1a46ce4c089e32c40fcc66bb04b26a6a172:

  ARM: dts: at91: sama5d3_xplained: not all ADC channels are available (2017-04-10 12:28:06 +0200)

----------------------------------------------------------------
DT for 4.12:
 - Add SFRBU on sama5d2
 - DT improvements for sama5d2_xplained, sama5d3_xplained, at91sam9x5ek and
 Axentia TSE-850

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: dts: at91: sama5d2: add sfrbu
      ARM: dts: at91: sama5d2_xplained: enable RTC wakeup

Boris Brezillon (1):
      ARM: dts: at91: Fix matrix compatible

Cristian Birsan (1):
      ARM: dts: at91: Disable SPI on at91sam9x5ek to allow MCI1 to work.

Ludovic Desroches (2):
      ARM: dts: at91: sama5d3_xplained: fix ADC vref
      ARM: dts: at91: sama5d3_xplained: not all ADC channels are available

Peter Rosin (1):
      ARM: dts: at91: add envelope detector mux to the Axentia TSE-850

 .../devicetree/bindings/arm/atmel-at91.txt         |  3 ++-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  1 +
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  5 ++--
 arch/arm/boot/dts/at91-tse850-3.dts                | 29 +++++++++++++++++++++-
 arch/arm/boot/dts/at91sam9261.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi                |  2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  5 ++++
 7 files changed, 40 insertions(+), 7 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
