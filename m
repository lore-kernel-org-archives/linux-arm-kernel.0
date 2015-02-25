From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 25 Feb 2015 13:36:17 +0000
Subject: [PATCH 6/6] MAINTAINERS: Add phy-miphy28lp.c to ARCH/STI architecture
In-Reply-To: <1424871377-1795-1-git-send-email-peter.griffin@linaro.org>
References: <1424871377-1795-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1424871377-1795-7-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the phy-miphy28lp.c phy driver found on STMicroelectronics
stih407 family SoC's into the STI arch section of the maintainers file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8c..1a6180a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1457,6 +1457,7 @@ F:	drivers/clocksource/arm_global_timer.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/mmc/host/sdhci-st.c
+F:	drivers/phy/phy-miphy28lp.c
 F:	drivers/phy/phy-stih407-usb.c
 F:	drivers/phy/phy-stih41x-usb.c
 F:	drivers/pinctrl/pinctrl-st.c
-- 
1.9.1
