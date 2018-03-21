From: swboyd@chromium.org (Stephen Boyd)
Date: Wed, 21 Mar 2018 11:48:11 -0700
Subject: [PATCH] regulator: qcom_smd: Drop regulator/{machine,
 of_regulator} includes
Message-ID: <20180321184811.120996-1-swboyd@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These seem to be leftovers from previous developments of the driver but
they never got removed. Dropping them still allows the code to compile
so everything must be fine.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/regulator/qcom_smd-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 940fe1b78411..0c6e681c7d89 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -17,8 +17,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/of_regulator.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
 struct qcom_rpm_reg {
-- 
Sent by a computer through tubes
