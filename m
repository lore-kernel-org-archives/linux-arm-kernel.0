From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 May 2018 12:03:15 -0500
Subject: [PATCH 0/6] hwspinlock: Convert to use SPDX license identifiers
Message-ID: <20180511170321.2452-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

The following series switches over the current licensing text in
various HwSpinlock drivers to the SPDX licensing format. Please
let me know if you need any changes. If you are ok with the changes,
I will make similar changes to the remoteproc and rpmsg drivers and
post them at the earliest so that they can be picked up for 4.18.

regards
Suman

Suman Anna (6):
  hwspinlock/core: Switch to SPDX license identifier
  hwspinlock/omap: Switch to SPDX license identifier
  hwspinlock: qcom: Switch to SPDX license identifier
  hwspinlock/sirf: Switch to SPDX license identifier
  hwspinlock/u8500: Switch to SPDX license identifier
  hwspinlock: sprd: Switch to SPDX license identifier

 drivers/hwspinlock/Kconfig               |  1 +
 drivers/hwspinlock/hwspinlock_core.c     | 10 +---------
 drivers/hwspinlock/hwspinlock_internal.h | 10 +---------
 drivers/hwspinlock/omap_hwspinlock.c     | 10 +---------
 drivers/hwspinlock/qcom_hwspinlock.c     | 10 +---------
 drivers/hwspinlock/sirf_hwspinlock.c     |  3 +--
 drivers/hwspinlock/sprd_hwspinlock.c     | 10 +---------
 drivers/hwspinlock/u8500_hsem.c          | 10 +---------
 include/linux/hwspinlock.h               | 10 +---------
 9 files changed, 9 insertions(+), 65 deletions(-)

-- 
2.17.0
