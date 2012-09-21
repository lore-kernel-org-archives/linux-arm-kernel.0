From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Sep 2012 09:38:57 +0800
Subject: [GIT PULL] mxs device tree changes for 3.7 (take 2)
Message-ID: <20120921013855.GJ2450@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0b2d795e189f441e499a60f2e17077635c3d616b:

  Merge tag 'mxs-clk-dt-lookup' into mxs/dt-for-3.7-2 (2012-09-17 14:26:52 +0800)

are available in the git repository at:


  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-dt-3.7-2

for you to fetch changes up to 7aff3fba8437438a86e6debe2429cd12a69b05d0:

  ARM: mxs: m28evk: Disable OCOTP OUI loading (2012-09-19 22:00:37 +0800)

----------------------------------------------------------------
This is the second round of mxs-dt patches for 3.7.  It's based on
mxs-dt-3.7 and mxs-clk-dt-lookup which have been pulled into arm-soc.

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: dts: mx23: Add USB resources
      ARM: dts: imx23-olinuxino: Add USB host support

Marek Vasut (2):
      ARM: dts: mxs: Add ethernetX to macX aliases
      ARM: mxs: m28evk: Disable OCOTP OUI loading

 arch/arm/boot/dts/imx23-olinuxino.dts |   26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/imx23.dtsi          |   10 ++++++++--
 arch/arm/boot/dts/imx28.dtsi          |    2 ++
 arch/arm/mach-mxs/mach-mxs.c          |    2 --
 4 files changed, 36 insertions(+), 4 deletions(-)
