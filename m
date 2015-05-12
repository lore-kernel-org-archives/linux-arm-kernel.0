From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 May 2015 13:58:09 +0100
Subject: [PATCH v2 01/12] mfd: dt-bindings: Provide human readable define for
 Clocksource mode
In-Reply-To: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431435500-22899-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST's Low Power Controller can now operate in three supported modes;
Watchdog, Real Time Clock and most recently as a Clocksource.  This new
define will allow the LPC IP to be configured for Clocksource from DT.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/dt-bindings/mfd/st-lpc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/mfd/st-lpc.h b/include/dt-bindings/mfd/st-lpc.h
index e3e6c75..d05894a 100644
--- a/include/dt-bindings/mfd/st-lpc.h
+++ b/include/dt-bindings/mfd/st-lpc.h
@@ -11,5 +11,6 @@
 
 #define ST_LPC_MODE_RTC		0
 #define ST_LPC_MODE_WDT		1
+#define ST_LPC_MODE_CLKSRC	2
 
 #endif /* __DT_BINDINGS_ST_LPC_H__ */
-- 
1.9.1
