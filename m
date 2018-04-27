From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 28 Apr 2018 02:51:01 +0800
Subject: [PATCH 0/2] soc: imx: add scu power domain driver
Message-ID: <1524855063-14996-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds the scu based power domain driver.
It depends on SCU APIs patch set.

Dong Aisheng (2):
  dt-bindings: power: add i.MX SCU power domains binding doc
  soc: imx: add SCU power domains driver

 .../devicetree/bindings/power/nxp,imx-pd-scu.txt   |  84 ++++++++++++
 drivers/soc/imx/Kconfig                            |   4 +
 drivers/soc/imx/Makefile                           |   1 +
 drivers/soc/imx/sc-pd.c                            | 151 +++++++++++++++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/nxp,imx-pd-scu.txt
 create mode 100644 drivers/soc/imx/sc-pd.c

-- 
2.7.4
