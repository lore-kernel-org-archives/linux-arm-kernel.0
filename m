From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Nov 2012 16:56:17 +0800
Subject: [GIT PULL] mxs device tree changes for 3.8 (take 2)
Message-ID: <20121122085611.GG24693@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4e556c046df2bd8d6eef6403c25bf8e52f64be93:

  ARM: mxs_defconfig: Improve USB related support (2012-11-16 15:11:32 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-dt-3.8-2

for you to fetch changes up to 25d6dd859e73248432051257b4b4d2a3d51b295b:

  ARM: dts: mxs: add oled support for the cfa-10036 (2012-11-22 09:03:40 +0800)

----------------------------------------------------------------
They are a few mxs dts updates coming a little bit late.  I'm sending
them as the second mxs/dt pull request for 3.8.  Please consider to
pull.

----------------------------------------------------------------
Fadil Berisha (1):
      ARM: imx23-olinuxino: Add spi support

Marek Vasut (1):
      ARM: mxs: Add SchulerControl SPS1 DTS file

Maxime Ripard (1):
      ARM: dts: mxs: add oled support for the cfa-10036

 arch/arm/boot/dts/Makefile            |    1 +
 arch/arm/boot/dts/imx23-olinuxino.dts |    9 ++
 arch/arm/boot/dts/imx23.dtsi          |   13 +++
 arch/arm/boot/dts/imx28-cfa10036.dts  |   19 ++++
 arch/arm/boot/dts/imx28-sps1.dts      |  169 +++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c          |    7 ++
 6 files changed, 218 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-sps1.dts
