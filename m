From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 13:39:02 +0800
Subject: [GIT PULL] mxs_defconfig updates for 3.6
Message-ID: <20120706053900.GD20503@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following mxs_defconfig updates for 3.6.

Regards,
Shawn

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/defconfig-for-3.6

Fabio Estevam (5):
      ARM: mxs: Let GPMI driver be built by default
      ARM: mxs: Enable MACH_APX4DEVKIT
      ARM: mxs_defconfig: Let AUART driver be built by default
      ARM: mxs_defconfig: Enable RTC driver
      ARM: mxs: defconfig: Enable CONFIG_COMMON_CLK_DEBUG

 arch/arm/configs/mxs_defconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)
