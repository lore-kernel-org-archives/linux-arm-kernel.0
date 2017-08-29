From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 29 Aug 2017 22:52:34 +0200
Subject: [GIT PULL] ARM: at91: DT for 4.14
Message-ID: <20170829205234.fovfblt4l6gkex64@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

I understand this is very late in the cycle but I completely forgot to
send that pull request alongside the 4.13 fixes.
Most of the patches have been included in linux-next for a while so I
don't this it is too risky to take it now.

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.14-dt

for you to fetch changes up to 1a9f9af07e806dd4d5df109c61ac0d5c74fe9b32:

  ARM: dts: at91: at91sam9g45: add AC97 (2017-07-30 00:48:20 +0200)

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
