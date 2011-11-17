From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Nov 2011 21:19:01 +0800
Subject: [GIT PULL] imx6q: fix for v3.2-rc
Message-ID: <20111117131901.GL14656@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the imx6q fix below for v3.2-rc.

Regards,
Shawn

The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:

  Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx6q/fixes

Richard Zhao (1):
      ARM: imx6q: move clock register map to machine_desc.map_io

 arch/arm/mach-imx/clock-imx6q.c         |    7 +++++--
 arch/arm/mach-imx/mach-imx6q.c          |    1 +
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)
