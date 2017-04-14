From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 14 Apr 2017 10:00:50 +0200
Subject: [GIT PULL v2] ARM: at91: DT for 4.12
In-Reply-To: <20170410163557.qocx3bvz5s5gcnkw@piout.net>
Message-ID: <20170414080050.qb3n7ypomgciqa22@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

As you didn't seem to have taken the previous version, I've folded a
late minute fix in Peter's patch. IF that is not OK, I'll sent the fix
later.

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.12-dt

for you to fetch changes up to d3df1ec06353e51fc44563d2e7e18d42811af290:

  ARM: dts: at91: sama5d3_xplained: not all ADC channels are available (2017-04-14 09:38:51 +0200)

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
