From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 11 Aug 2014 11:09:12 +0100
Subject: [PATCH v2 3/3] MAINTAINERS: Add phy-stih41x-usb.c to ARCH/STI
 architecture
In-Reply-To: <1407751752-32383-1-git-send-email-peter.griffin@linaro.org>
References: <1407751752-32383-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1407751752-32383-4-git-send-email-peter.griffin@linaro.org>
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
index c2066f4..6283d83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1356,6 +1356,7 @@ F:	drivers/pinctrl/pinctrl-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/tty/serial/st-asc.c
+F:	drivers/phy/phy-stih41x-usb.c
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.9.1
