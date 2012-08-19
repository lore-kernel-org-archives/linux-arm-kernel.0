From: stigge@antcom.de (Roland Stigge)
Date: Sun, 19 Aug 2012 13:04:29 +0200
Subject: [PATCH] USB: isp1301: Remove unused static array and define
Message-ID: <1345374269-5471-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes an unused statically defined array and an associated #define.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
Applies to v3.6-rc2

 drivers/usb/phy/isp1301.c |    6 ------
 1 file changed, 6 deletions(-)

--- linux-2.6.orig/drivers/usb/phy/isp1301.c
+++ linux-2.6/drivers/usb/phy/isp1301.c
@@ -15,12 +15,6 @@
 
 #define DRV_NAME		"isp1301"
 
-#define ISP1301_I2C_ADDR	0x2C
-
-static const unsigned short normal_i2c[] = {
-	ISP1301_I2C_ADDR, ISP1301_I2C_ADDR + 1, I2C_CLIENT_END
-};
-
 static const struct i2c_device_id isp1301_id[] = {
 	{ "isp1301", 0 },
 	{ }
