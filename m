From: rob.lee@linaro.org (Robert Lee)
Date: Mon, 16 Apr 2012 18:50:11 -0500
Subject: [PATCH 0/3] Add imx cpuidle
Message-ID: <1334620214-25803-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add common imx cpuidle initialization functionality and add a i.MX5 and i.MX6
platform cpuidle implementation.

Robert Lee (3):
  ARM: imx: Add common imx cpuidle init functionality.
  ARM: imx: Add imx5 cpuidle driver
  ARM: imx: Add imx6q cpuidle driver

 arch/arm/mach-imx/Makefile               |    4 +-
 arch/arm/mach-imx/cpuidle-imx5.c         |   55 ++++++++++++++++++
 arch/arm/mach-imx/cpuidle-imx6q.c        |   33 +++++++++++
 arch/arm/mach-imx/mach-imx6q.c           |    2 +
 arch/arm/mach-imx/mm-imx5.c              |   16 ++++--
 arch/arm/plat-mxc/Makefile               |    2 +
 arch/arm/plat-mxc/cpuidle.c              |   89 ++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h  |    1 +
 arch/arm/plat-mxc/include/mach/cpuidle.h |   26 +++++++++
 9 files changed, 222 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx5.c
 create mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c
 create mode 100644 arch/arm/plat-mxc/cpuidle.c
 create mode 100644 arch/arm/plat-mxc/include/mach/cpuidle.h

-- 
1.7.10
