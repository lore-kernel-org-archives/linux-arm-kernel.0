From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 28 Jul 2015 15:00:25 +0800
Subject: [PATCH 2/2] Documentation: dt: binding: atmel-wdt: add a new
 compitable
In-Reply-To: <1438066825-21923-1-git-send-email-wenyou.yang@atmel.com>
References: <1438066825-21923-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1438066825-21923-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new compatible "atmel,sama5d4-wdt" for SAMA5D4,
which suports the new feature, the WDT_MR register can be written more once.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 .../devicetree/bindings/watchdog/atmel-wdt.txt     |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
index a4d8697..060c682 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
@@ -3,7 +3,9 @@
 ** at91sam9-wdt
 
 Required properties:
-- compatible: must be "atmel,at91sam9260-wdt".
+- compatible : should be one among the following
+	(a) "atmel,at91sam9260-wdt" for AT91SAM9x and SAMA5D3 SoCs
+	(b) "atmel,sama5d4-wdt" for SAMA5D4
 - reg: physical base address of the controller and length of memory mapped
   region.
 
-- 
1.7.9.5
