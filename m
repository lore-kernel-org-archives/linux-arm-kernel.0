From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed,  6 Jul 2016 01:58:25 +0530
Subject: [PATCH 0/2] Add PMU support for Exynos7
Message-ID: <1467750507-13853-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Power Management Unit on Exynos7. These patches
have been tested on an Exynos7 espresso board (next-20160704).

Abhilash Kesavan (2):
  soc: samsung: Change type of PMU configuration register value to u32
  soc: samsung: Add support for Exynos7 PMU

 drivers/soc/samsung/Makefile                |   3 +-
 drivers/soc/samsung/exynos-pmu.c            |   3 +
 drivers/soc/samsung/exynos-pmu.h            |   4 +-
 drivers/soc/samsung/exynos7-pmu.c           | 367 ++++++++++++++++++++++++++++
 include/linux/soc/samsung/exynos-regs-pmu.h | 259 ++++++++++++++++++++
 5 files changed, 634 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/samsung/exynos7-pmu.c

-- 
1.9.1
