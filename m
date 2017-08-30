From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Aug 2017 18:39:05 +0200
Subject: [GIT PULL] ARM: at91: DT for 4.14#2
Message-ID: <20170830163905.x4kol7iyg466fzvz@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

As discussed, this replaces the previous pull request. The only change
is the fixed up SoB.

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.14-dt2

for you to fetch changes up to 2b17939d9ec4f5d8c50b6277a8e5c0e5a4a8c96b:

  ARM: dts: at91: at91sam9g45: add AC97 (2017-08-30 18:30:56 +0200)

----------------------------------------------------------------
DT for 4.14

 - sama5d2: add classD, ISC and QSPI
 - New SoM and board: sama5d27 SoM1
 - at91sam9g45: add AC97

----------------------------------------------------------------
Claudiu Beznea (2):
      ARM: dts: at91: at91-sama5d27_som1: add sama5d27 SoM1 support
      ARM: dts: at91: at91-sama5d27_som1_ek: Add sama5d27 SoM1 EK support

Cyrille Pitchen (3):
      ARM: dts: at91: sama5d2: add QSPI nodes
      ARM: dts: at91: sama5d2: add classd nodes
      ARM: dts: at91: sama5d2_xplained: add pin muxing and enable classd

Dmitry Rezvanov (1):
      ARM: dts: at91: at91sam9g45: add AC97

Ludovic Desroches (1):
      ARM: dts: at91: sama5d2_xplained: use pin macros instead of numbers

Songjun Wu (1):
      ARM: dts: at91: sama5d2: add isc node

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi   | 102 ++++++
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 537 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  39 +-
 arch/arm/boot/dts/at91sam9g45.dtsi          |  21 ++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |   4 +
 arch/arm/boot/dts/sama5d2.dtsi              |  77 +++-
 7 files changed, 769 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1.dtsi
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
