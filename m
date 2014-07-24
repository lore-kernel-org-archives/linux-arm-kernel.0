From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 24 Jul 2014 12:00:16 +0100
Subject: [PATCH v2 3/3] MAINTAINERS: Add st-hcd to ARCH/STI architecture
In-Reply-To: <1406199616-10533-1-git-send-email-peter.griffin@linaro.org>
References: <1406199616-10533-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1406199616-10533-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 702ca10..359a64e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1325,6 +1325,7 @@ F:	drivers/pinctrl/pinctrl-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/tty/serial/st-asc.c
+F:	drivers/usb/host/st-hcd.c
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.9.1
