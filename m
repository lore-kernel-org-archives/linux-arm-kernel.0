From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Fri, 12 Jan 2018 16:22:57 +0200
Subject: [PATCH v2 10/16] pwm: Add PWM modes
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1515766983-15151-11-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a macros for PWM modes to be used by device tree sources.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/dt-bindings/pwm/pwm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index ab9a077e3c7d..b8617431f8ec 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -12,4 +12,7 @@
 
 #define PWM_POLARITY_INVERTED			(1 << 0)
 
+#define PWM_DTMODE_NORMAL			(1 << 0)
+#define PWM_DTMODE_COMPLEMENTARY		(1 << 1)
+
 #endif
-- 
2.7.4
