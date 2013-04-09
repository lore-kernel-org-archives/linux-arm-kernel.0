From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 09 Apr 2013 17:55:08 +0200
Subject: [GIT PULL] sunXi DT additions for 3.10, take 3
Message-ID: <516439DC.5010009@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please consider pulling the following pull request.

It should be our last for the 3.10 merge window.

Thanks,
Maxime

The following changes since commit 36386d6e54d0ebcd5b2e0869f837800293d94c3c:

  arm: sunxi: Add clock to pinctrl node (2013-04-04 23:45:30 +0200)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-dt-for-3.10-3

for you to fetch changes up to 0b19b7c2c6e169efccb4b1632fe628969d001618:

  ARM: sunxi: dt: Update watchdog compatible string (2013-04-08 21:56:34 +0200)

----------------------------------------------------------------
SunXi dt additions for 3.10, take 3
  - Remove sunxi.dtsi and only use one dtsi for each SoC
  - Various compatible renamings to be consistent with the other platforms

----------------------------------------------------------------
Maxime Ripard (4):
      ARM: sunxi: dt: Reorganize the dtsi
      ARM: sunxi: dt: Update timer compatible string
      ARM: sunxi: dt: Update interrupt controller compatible string
      ARM: sunxi: dt: Update watchdog compatible string

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |    2 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts  |    2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi           |  194 +++++++++++++++++++++++++-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts  |    2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi           |  194 +++++++++++++++++++++++++-
 arch/arm/boot/dts/sunxi.dtsi               |  208 ----------------------------
 6 files changed, 387 insertions(+), 215 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sunxi.dtsi

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
