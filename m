From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 12 Aug 2011 15:04:43 +0800
Subject: [PATCH 0/2] Add NAND support for i.MX53EVK board
Message-ID: <1313132685-10440-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add NAND support for i.MX53EVK board, the patche-set
has already been tested on i.MX53EVK board with Samsung K9LAG08U0M

Jason Liu (3):
  ARM: i.MX53: Add NAND device support
  ARM: i.MX53EVK: Add NAND support for i.MX53evk board

 arch/arm/mach-mx5/Kconfig                     |    1 +
 arch/arm/mach-mx5/board-mx53_evk.c            |   47 +++++++++++++++++++++++++
 arch/arm/mach-mx5/clock-mx51-mx53.c           |    1 +
 arch/arm/mach-mx5/devices-imx53.h             |    4 ++
 arch/arm/plat-mxc/devices/platform-mxc_nand.c |    5 +++
 6 files changed, 59 insertions(+), 1 deletions(-)

-- 
1.7.4.1
