From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 20 Oct 2016 11:41:31 +0200
Subject: [PATCH v2 2/6] ARM: at91: Document samx7 compatibles
In-Reply-To: <20161020094135.18221-1-alexandre.belloni@free-electrons.com>
References: <20161020094135.18221-1-alexandre.belloni@free-electrons.com>
Message-ID: <20161020094135.18221-3-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce necessary compatibles to describe the samx7 family

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/arm/atmel-at91.txt         | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index e1f5ad855f14..baf9607c5f14 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -41,6 +41,36 @@ compatible: must be one of:
        - "atmel,sama5d43"
        - "atmel,sama5d44"
 
+ * "atmel,samx7" for MCUs using a Cortex-M7, shall be extended with the specific
+   SoC family:
+    o "atmel,sams70" shall be extended with the specific MCU compatible:
+       - "atmel,sams70j19"
+       - "atmel,sams70j20"
+       - "atmel,sams70j21"
+       - "atmel,sams70n19"
+       - "atmel,sams70n20"
+       - "atmel,sams70n21"
+       - "atmel,sams70q19"
+       - "atmel,sams70q20"
+       - "atmel,sams70q21"
+    o "atmel,samv70" shall be extended with the specific MCU compatible:
+       - "atmel,samv70j19"
+       - "atmel,samv70j20"
+       - "atmel,samv70n19"
+       - "atmel,samv70n20"
+       - "atmel,samv70q19"
+       - "atmel,samv70q20"
+    o "atmel,samv71" shall be extended with the specific MCU compatible:
+       - "atmel,samv71j19"
+       - "atmel,samv71j20"
+       - "atmel,samv71j21"
+       - "atmel,samv71n19"
+       - "atmel,samv71n20"
+       - "atmel,samv71n21"
+       - "atmel,samv71q19"
+       - "atmel,samv71q20"
+       - "atmel,samv71q21"
+
 Chipid required properties:
 - compatible: Should be "atmel,sama5d2-chipid"
 - reg : Should contain registers location and length
-- 
2.9.3
