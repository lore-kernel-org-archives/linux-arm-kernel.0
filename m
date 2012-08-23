From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Aug 2012 17:34:11 +0800
Subject: [GIT PULL] imx fixes for 3.6 (take 2)
Message-ID: <20120823093407.GE24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following imx fixes for 3.6-rc.  Thanks.

Regards,
Shawn

The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:

  Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/fixes-for-3.6

Philipp Zabel (1):
      ARM i.MX6q: Add virtual 1/3.5 dividers in the LDB clock path

Shawn Guo (3):
      ARM: imx6q: remove imx_src_prepare_restart() call
      ARM: imx6: spin the cpu until hardware takes it down
      ARM: dts: imx51-babbage: fix esdhc cd/wp properties

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    8 +++---
 arch/arm/boot/dts/imx51-babbage.dts                |    4 +-
 arch/arm/mach-imx/clk-imx6q.c                      |    8 ++++--
 arch/arm/mach-imx/hotplug.c                        |   23 ++-----------------
 arch/arm/mach-imx/mach-imx6q.c                     |    2 -
 arch/arm/mach-imx/src.c                            |   13 -----------
 arch/arm/plat-mxc/include/mach/common.h            |    1 -
 7 files changed, 14 insertions(+), 45 deletions(-)
