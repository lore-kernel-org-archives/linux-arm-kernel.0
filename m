From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon,  8 Sep 2014 11:33:02 +0100
Subject: [PATCH v4 3/4] MAINTAINERS: Add phy-stih41x-usb.c to ARCH/STI
 architecture
In-Reply-To: <1410172383-17306-1-git-send-email-peter.griffin@linaro.org>
References: <1410172383-17306-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1410172383-17306-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the new phy-sti41x-usb.c PHY driver found on
STMicroelectronics stih41x consumer electronics SoC's into the STI
arch section of the maintainers file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf24bb5..4cb59cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1398,6 +1398,7 @@ F:	drivers/media/rc/st_rc.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/tty/serial/st-asc.c
 F:	drivers/mmc/host/sdhci-st.c
+F:	drivers/phy/phy-stih41x-usb.c
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.9.1
