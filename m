From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Nov 2012 15:55:52 +0100
Subject: [PULL] at91: mmc suport + pinctrl
Message-ID: <20121121145552.GW4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	the follwong patch add the pinctrl support the mmc woth done by
	Ludovic

based on your current pinctrl/at91 branch

Please pull
The following changes since commit 17d6b293e72547f75f5d9b680b75459cb8f2c9cf:

  Merge branch 'delivery/pinctrl-at91-3.8' of http://github.com/at91linux/linux-at91 into at91 (2012-11-21 10:48:33 +0100)

are available in the git repository at:


  git://github.com/at91linux/linux-at91.git at91-3.8-pinctrl+mmc

for you to fetch changes up to c12a819e3ad9147acec3f20201fd51144f2244e9:

  ARM: at91: pm9g45: add mmc support (2012-11-20 01:10:28 +0800)

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (4):
      ARM: at91: dt: at91sam9: add mmc pinctrl support
      ARM: at91: dt: add mmc pinctrl for Atmel reference boards
      ARM: at91: Animeo IP: add mmc support
      ARM: at91: pm9g45: add mmc support

Ludovic Desroches (3):
      ARM: at91: add clocks for DT entries
      ARM: at91/dts: add nodes for atmel hsmci controllers for atmel SOCs
      ARM: at91/dts: add nodes for atmel hsmci controllers for atmel boards

 arch/arm/boot/dts/animeo_ip.dts             |   12 ++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi          |   42 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi          |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263ek.dts         |   25 +++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    |   26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   23 +++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi          |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |   44 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12.dtsi          |   33 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi           |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |   42 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/pm9g45.dts                |   21 +++++++++++++++++++++
 arch/arm/mach-at91/at91sam9260.c            |    1 +
 arch/arm/mach-at91/at91sam9263.c            |    2 ++
 arch/arm/mach-at91/at91sam9g45.c            |    2 ++
 arch/arm/mach-at91/at91sam9n12.c            |    1 +
 arch/arm/mach-at91/at91sam9x5.c             |    2 ++
 18 files changed, 498 insertions(+)

Best Regards,
J.
