From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Feb 2013 17:08:36 +0100
Subject: [GIT PULL] sunXi dt additions for 3.9, take 2
Message-ID: <512CDE04.2010401@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is the second pull request for DT additions for 3.9, containing
the commits that were reverted, plus the missing commit that makes
everything build.

It depends on patches that were merged by LinusT and went through
LinusW pinctrl tree, during this merge window.

Thanks,
Maxime

The following changes since commit 581981be24f9866b37af535f947da2e7b65aaa53:

  ARM: sunxi: Add the pin groups for UART0 and UART1 on sun4i (2013-02-01 10:48:11 +0100)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-dt-for-3.9-2

for you to fetch changes up to bb07ccd30af4b79fc5a4ad5b2f69b0a719b2f726:

  sunxi: a13-olinuxino: Add user LED to the device tree (2013-02-26 16:40:00 +0100)

----------------------------------------------------------------
2nd set of DT additions for the allwinner sunXi platform for linux 3.9

----------------------------------------------------------------
Emilio L?pez (1):
      sunxi: a10-cubieboard: Add user LEDs to the device tree

Maxime Ripard (2):
      sunxi: dts: Report the pinctrl nodes as gpio-controllers
      sunxi: a13-olinuxino: Add user LED to the device tree

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |   26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi           |    4 +++-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts  |   20 ++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi           |    4 +++-
 4 files changed, 52 insertions(+), 2 deletions(-)

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
