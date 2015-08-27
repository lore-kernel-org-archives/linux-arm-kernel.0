From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Thu, 27 Aug 2015 14:34:17 +0200
Subject: [PATCH v4 4/4] MAINTAINERS: Add pci-st.c to ARCH/STI architecture
In-Reply-To: <1440678857-27118-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1440678857-27118-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1440678857-27118-5-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the pci-st.c pci driver found on STMicroelectronics
SoC's into the STI arch section of the maintainers file.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cef..af5034f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1506,6 +1506,7 @@ F:	drivers/clocksource/arm_global_timer.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/mmc/host/sdhci-st.c
+F:	drivers/pci/host/pci-st.c
 F:	drivers/phy/phy-miphy28lp.c
 F:	drivers/phy/phy-miphy365x.c
 F:	drivers/phy/phy-stih407-usb.c
-- 
1.9.1
