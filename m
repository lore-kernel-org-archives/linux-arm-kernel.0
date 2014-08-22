From: dmurphy@ti.com (Dan Murphy)
Date: Fri, 22 Aug 2014 09:11:15 -0500
Subject: [PATCH] input: misc: drv260x remove defines not used
Message-ID: <1408716675-1093-1-git-send-email-dmurphy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing some #defines that are not and should
never be used pertaining to I2C.

Removing:
define DRV260X_ALLOWED_R_BYTES	25
define DRV260X_ALLOWED_W_BYTES	2
define DRV260X_MAX_RW_RETRIES	5
define DRV260X_I2C_RETRY_DELAY 10

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/input/misc/drv260x.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index e90e3b8..a7a19e6 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -66,11 +66,6 @@
 #define DRV260X_LRA_RES_PERIOD	0x22
 #define DRV260X_MAX_REG			0x23
 
-#define DRV260X_ALLOWED_R_BYTES	25
-#define DRV260X_ALLOWED_W_BYTES	2
-#define DRV260X_MAX_RW_RETRIES	5
-#define DRV260X_I2C_RETRY_DELAY 10
-
 #define DRV260X_GO_BIT				0x01
 
 /* Library Selection */
-- 
1.7.9.5
