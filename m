From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 28 Jul 2017 11:53:08 +0200
Subject: [PATCH v2 3/4] dt-bindings: clock: gxbb-aoclk: Add CEC 32k clock
In-Reply-To: <1501235589-318-1-git-send-email-narmstrong@baylibre.com>
References: <1501235589-318-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1501235589-318-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchadds the clock binding entry for the CEC 32K AO Clock.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/clock/gxbb-aoclkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/gxbb-aoclkc.h b/include/dt-bindings/clock/gxbb-aoclkc.h
index 3175148..9d15e22 100644
--- a/include/dt-bindings/clock/gxbb-aoclkc.h
+++ b/include/dt-bindings/clock/gxbb-aoclkc.h
@@ -62,5 +62,6 @@
 #define CLKID_AO_UART1		3
 #define CLKID_AO_UART2		4
 #define CLKID_AO_IR_BLASTER	5
+#define CLKID_AO_CEC_32K	6
 
 #endif
-- 
1.9.1
