From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 4 Dec 2015 21:57:00 +0800
Subject: [PATCH 1/2] phy: berlin-usb: remove non-necessary header files
In-Reply-To: <1449237421-5552-1-git-send-email-jszhang@marvell.com>
References: <1449237421-5552-1-git-send-email-jszhang@marvell.com>
Message-ID: <1449237421-5552-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need gpio related header files, so remove them.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/phy/phy-berlin-usb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/phy/phy-berlin-usb.c b/drivers/phy/phy-berlin-usb.c
index 797ba17..7bbb473 100644
--- a/drivers/phy/phy-berlin-usb.c
+++ b/drivers/phy/phy-berlin-usb.c
@@ -9,11 +9,9 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
-- 
2.6.2
