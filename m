From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  9 Sep 2014 10:00:17 +0100
Subject: [PATCH v2 3/4] MAINTAINERS: Add phy-stih407-usb.c file to ARCH/STI
 architecture
In-Reply-To: <1410253218-18318-1-git-send-email-peter.griffin@linaro.org>
References: <1410253218-18318-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1410253218-18318-4-git-send-email-peter.griffin@linaro.org>
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
index cf24bb5..3ccb4cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1398,6 +1398,7 @@ F:	drivers/media/rc/st_rc.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/tty/serial/st-asc.c
 F:	drivers/mmc/host/sdhci-st.c
+F:	drivers/phy/phy-stih407-usb.c
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.9.1
