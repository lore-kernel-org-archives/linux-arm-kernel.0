From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 13:48:20 +0800
Subject: [GIT PULL] imx6 device tree changes for 3.6
Message-ID: <20120706054818.GF20503@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following imx6 device tree related changes for 3.6.

Regards,
Shawn

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/dt-for-3.6

Huang Shijie (4):
      ARM: imx6q: add DT node for apbh-dma
      ARM: imx6q: add clock for apbh-dma
      ARM: imx6q: add DT node for gpmi nand
      ARM: imx6q: add clocks for gpmi-nand

Marc Kleine-Budde (1):
      ARM: imx: enable flexcan on imx25, imx35, imx53, imx6q

 arch/arm/boot/dts/imx6q-arm2.dts |    6 +++++
 arch/arm/boot/dts/imx6q.dtsi     |   41 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/Kconfig        |    4 +++
 arch/arm/mach-imx/clk-imx6q.c    |   11 ++++++++-
 4 files changed, 60 insertions(+), 2 deletions(-)
