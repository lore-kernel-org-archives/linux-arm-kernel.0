From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  1 Apr 2015 07:42:41 +0100
Subject: [PATCH v3] MAINTAINERS: Add phy-miphy28lp.c and phy-miphy365x.c to
 ARCH/STI architecture
Message-ID: <1427870561-4073-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the phy-miphy28lp.c and phy-miphy365x.c phy drivers found on
STMicroelectronics stih407 family SoC's into the STI arch section of the
maintainers file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1de6afa..60897e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1469,6 +1469,8 @@ F:	drivers/clocksource/arm_global_timer.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/mmc/host/sdhci-st.c
+F:	drivers/phy/phy-miphy28lp.c
+F:	drivers/phy/phy-miphy365x.c
 F:	drivers/phy/phy-stih407-usb.c
 F:	drivers/phy/phy-stih41x-usb.c
 F:	drivers/pinctrl/pinctrl-st.c
-- 
1.9.1
