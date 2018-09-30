From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun, 30 Sep 2018 08:53:15 +0800
Subject: [PATCH V3 0/2] soc: imx: add scu power domain driver
Message-ID: <1538268797-24830-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds the scu based power domain driver.
It depends on SCU driver.

Change Log:
v2->v3:
 * structure and enums name update
 * api usage update

Dong Aisheng (2):
  firmware: imx: add pm svc headfile
  firmware: imx: add SCU power domain driver

 drivers/firmware/imx/Kconfig  |   6 ++
 drivers/firmware/imx/Makefile |   3 +-
 drivers/firmware/imx/scu-pd.c | 168 ++++++++++++++++++++++++++++++++++++++++++
 include/soc/imx/scu/sci.h     |   1 +
 include/soc/imx/scu/svc/pm.h  |  85 +++++++++++++++++++++
 5 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/scu-pd.c
 create mode 100644 include/soc/imx/scu/svc/pm.h

-- 
2.7.4
