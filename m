From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu,  7 Aug 2014 16:21:44 +0100
Subject: [PATCH v4 5/5] MAINTAINERS: Add ehci-st.c and ohci-st.c to ARCH/STI
 architecture
In-Reply-To: <1407424904-19251-1-git-send-email-peter.griffin@linaro.org>
References: <1407424904-19251-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1407424904-19251-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2066f4..89aef87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1356,6 +1356,8 @@ F:	drivers/pinctrl/pinctrl-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/tty/serial/st-asc.c
+F:	drivers/usb/host/ehci-st.c
+F:	drivers/usb/host/ohci-st.c
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.9.1
