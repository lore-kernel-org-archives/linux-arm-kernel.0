From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  3 Sep 2014 11:27:59 +0100
Subject: [PATCH 3/3] MAINTAINERS: Add phy-stih407-usb.c file to ARCH/STI
 architecture
In-Reply-To: <1409740079-16554-1-git-send-email-peter.griffin@linaro.org>
References: <1409740079-16554-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1409740079-16554-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the new phy-stih407-usb.c usb phy driver found on
STMicroelectronics stih407 consumer electronics SoC's into the STI
arch section of the maintainers file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55381955..0d0818a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1399,6 +1399,7 @@ F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/tty/serial/st-asc.c
 F:	drivers/mmc/host/sdhci-st.c
 F:	drivers/usb/dwc3/dwc3-st.c
+F:	drivers/phy/phy-stih407-usb.c
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.9.1
