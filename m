From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Wed, 21 Nov 2018 21:30:47 +0300
Subject: [RFC PATCH v3 14/17] dt-bindings: watchdog: Add Allwinner ARMv5
 F1C100s wdt
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Message-ID: <713a56409ba6afb4896d3ac9617f1784c7889f0f.1542824904.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner ARMv5 F1C100s has similar watchdog timer to sun6i A31.
Add definition for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
index ed11ce0..5eefc56 100644
--- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 	"allwinner,sun4i-a10-wdt"
 	"allwinner,sun6i-a31-wdt"
 	"allwinner,sun50i-a64-wdt","allwinner,sun6i-a31-wdt"
+	"allwinner,suniv-f1c100s-wdt"
 - reg : Specifies base physical address and size of the registers.
 
 Optional properties:
-- 
2.7.4
