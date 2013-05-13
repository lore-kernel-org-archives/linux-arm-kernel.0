From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 May 2013 09:16:02 +0800
Subject: [PATCH] pinctrl: enable build of pinctrl-imx6sl driver
Message-ID: <1368407762-12084-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl-imx6sl is in place.  Enable the build of it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pinctrl/Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 9bdaeb8..34c4ae6 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_PINCTRL_IMX51)	+= pinctrl-imx51.o
 obj-$(CONFIG_PINCTRL_IMX53)	+= pinctrl-imx53.o
 obj-$(CONFIG_PINCTRL_IMX6Q)	+= pinctrl-imx6q.o
 obj-$(CONFIG_PINCTRL_IMX6Q)	+= pinctrl-imx6dl.o
+obj-$(CONFIG_PINCTRL_IMX6SL)	+= pinctrl-imx6sl.o
 obj-$(CONFIG_PINCTRL_FALCON)	+= pinctrl-falcon.o
 obj-$(CONFIG_PINCTRL_MXS)	+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_IMX23)	+= pinctrl-imx23.o
-- 
1.7.9.5
