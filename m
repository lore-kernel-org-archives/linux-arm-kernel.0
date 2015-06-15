From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 15 Jun 2015 13:54:29 +0900
Subject: [PATCH] pinctrl: samsung: Remove old unused defines
Message-ID: <1434344069-19133-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 9a2c1c3b91aa ("pinctrl: samsung: Allow grouping multiple
pinmux/pinconf nodes") the defines for GPIO group and function names are
not used anywhere in the driver.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Inspired-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 3dd5a3b2ac62..c760bf43d116 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -33,11 +33,6 @@
 #include "../core.h"
 #include "pinctrl-samsung.h"
 
-#define GROUP_SUFFIX		"-grp"
-#define GSUFFIX_LEN		sizeof(GROUP_SUFFIX)
-#define FUNCTION_SUFFIX		"-mux"
-#define FSUFFIX_LEN		sizeof(FUNCTION_SUFFIX)
-
 /* list of all possible config options supported */
 static struct pin_config {
 	const char *property;
-- 
1.9.1
