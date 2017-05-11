From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Thu, 11 May 2017 12:17:40 +0530
Subject: [PATCH v5 1/3] phy: qcom-usb: Remove unused ulpi phy header
Message-ID: <1494485262-18995-1-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulpi phy header is not used for anything. Remove the same
from qcom-hs and qcom-hsic phy drivers.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Suggested-by: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-usb at vger.kernel.org
---

Changes since v4:
 - None.

Changes since v3:
 - New patch added in the series.
   Removing headers as per Stephen's suggestion.

 drivers/phy/phy-qcom-usb-hs.c   | 2 --
 drivers/phy/phy-qcom-usb-hsic.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/phy/phy-qcom-usb-hs.c b/drivers/phy/phy-qcom-usb-hs.c
index 94dfbfd739c3..43704f4f23e9 100644
--- a/drivers/phy/phy-qcom-usb-hs.c
+++ b/drivers/phy/phy-qcom-usb-hs.c
@@ -15,8 +15,6 @@
 #include <linux/extcon.h>
 #include <linux/notifier.h>
 
-#include "ulpi_phy.h"
-
 #define ULPI_PWR_CLK_MNG_REG		0x88
 # define ULPI_PWR_OTG_COMP_DISABLE	BIT(0)
 
diff --git a/drivers/phy/phy-qcom-usb-hsic.c b/drivers/phy/phy-qcom-usb-hsic.c
index 47690f9945b9..6dcaf04fa367 100644
--- a/drivers/phy/phy-qcom-usb-hsic.c
+++ b/drivers/phy/phy-qcom-usb-hsic.c
@@ -13,8 +13,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 
-#include "ulpi_phy.h"
-
 #define ULPI_HSIC_CFG		0x30
 #define ULPI_HSIC_IO_CAL	0x33
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
