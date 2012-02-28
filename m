From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Feb 2012 10:23:20 +0800
Subject: [GIT PULL] mxs gpmi for v3.4
Message-ID: <20120228022318.GD13886@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following mxs gpmi device patch for v3.4.

Regards,
Shawn

The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:

  Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/gpmi

Huang Shijie (1):
      ARM: mxs: add GPMI-NAND support for imx23/imx28

 arch/arm/mach-mxs/clock-mx23.c                  |    1 +
 arch/arm/mach-mxs/clock-mx28.c                  |    1 +
 arch/arm/mach-mxs/devices-mx23.h                |    4 +
 arch/arm/mach-mxs/devices-mx28.h                |    4 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-gpmi-nand.c  |   81 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   10 +++
 8 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi-nand.c
