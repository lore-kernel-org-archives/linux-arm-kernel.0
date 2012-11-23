From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 23 Nov 2012 19:41:15 +0100
Subject: [PULL] at91: spi suport + pinctrl
Message-ID: <20121123184115.GB4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	the following patch add the spi and its pinctrl support
	to the sam9 IP that use the PDC (9263/9260/9g20/9g45)

based on the mmc pull request

please pull

The following changes since commit c12a819e3ad9147acec3f20201fd51144f2244e9:

  ARM: at91: pm9g45: add mmc support (2012-11-20 01:10:28 +0800)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git at91-3.8-pinctrl+mmc+spi

for you to fetch changes up to 1869d34b6e3ff5bcdf7059dad431b8ae3818a4f6:

  ARM: at91: dt: sam9m10g45ek add spi support (2012-11-22 04:51:42 +0800)

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (2):
      ARM: at91: sam9: add spi dt support
      ARM: at91: dt: sam9m10g45ek add spi support

 arch/arm/boot/dts/at91sam9260.dtsi     |   40 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi     |   40 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi     |   40 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/at91sam9260.c       |    2 ++
 arch/arm/mach-at91/at91sam9g45.c       |    2 ++
 6 files changed, 157 insertions(+)

Best Regards,
J.
