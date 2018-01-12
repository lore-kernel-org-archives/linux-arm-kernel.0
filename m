From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Fri, 12 Jan 2018 16:23:01 +0200
Subject: [PATCH v2 14/16] pwm: add push-pull mode
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1515766983-15151-15-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add macro for push-pull mode to be used in DT.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/dt-bindings/pwm/pwm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index b8617431f8ec..c6365807c30d 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -14,5 +14,6 @@
 
 #define PWM_DTMODE_NORMAL			(1 << 0)
 #define PWM_DTMODE_COMPLEMENTARY		(1 << 1)
+#define PWM_DTMODE_PUSH_PULL			(1 << 2)
 
 #endif
-- 
2.7.4
