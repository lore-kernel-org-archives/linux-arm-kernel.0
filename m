From: pramodku@broadcom.com (Pramod Kumar)
Date: Mon, 19 Oct 2015 11:13:15 +0530
Subject: [PATCH 08/11] pinctrl: Add new compatible string to GPIO controller
 driver
In-Reply-To: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
Message-ID: <1445233398-27129-9-git-send-email-pramodku@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This compatible string should be used for all new iproc based future
SoCs having the same GPIO controller hardware.

Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
index 498a58a..d0d788f 100644
--- a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
@@ -646,6 +646,7 @@ static const struct of_device_id cygnus_gpio_of_match[] = {
 	{ .compatible = "brcm,cygnus-ccm-gpio" },
 	{ .compatible = "brcm,cygnus-asiu-gpio" },
 	{ .compatible = "brcm,cygnus-crmu-gpio" },
+	{ .compatible = "brcm,iproc-gpio" },
 	{ }
 };
 
-- 
1.9.1
