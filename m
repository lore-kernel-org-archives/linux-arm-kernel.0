From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 4 Aug 2012 22:46:38 +0800
Subject: [GIT PULL] imx fixes for 3.6
Message-ID: <20120804144636.GC3405@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following imx fixes for 3.6.

Regards,
Shawn

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/fixes-for-3.6

Fabio Estevam (1):
      ARM: imx6q-sabrelite: Setup CLKO IOMUX

Shawn Guo (3):
      ARM: imx: enable emi_slow_gate clock for imx5
      ARM: dts: imx53-ard: add regulators for lan9220
      ARM: dts: imx: fix gpio interrupts property

 arch/arm/boot/dts/imx51-babbage.dts   |    2 +-
 arch/arm/boot/dts/imx53-ard.dts       |   22 +++++++++++++++++++++-
 arch/arm/boot/dts/imx6q-sabrelite.dts |    1 +
 arch/arm/mach-imx/clk-imx51-imx53.c   |    1 +
 4 files changed, 24 insertions(+), 2 deletions(-)
