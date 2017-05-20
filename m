From: cosardindar@gmail.com (Cosar Dindar)
Date: Sat, 20 May 2017 16:32:12 +0300
Subject: [PATCH v2 2/5] dt-bindings : Document the STM32F4 CRC32 binding
In-Reply-To: <cover.1495285223.git.cosardindar@gmail.com>
References: <cover.1495285223.git.cosardindar@gmail.com>
Message-ID: <bb672acb88667e9d27beb4d1e4fd8882f265ee47.1495285223.git.cosardindar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding for STM32F4.

Signed-off-by: Cosar Dindar <cosardindar@gmail.com>
---
 Documentation/devicetree/bindings/crypto/st,stm32-crc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt b/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
index 3ba92a5..7b30f1e 100644
--- a/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
+++ b/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
@@ -1,7 +1,7 @@
 * STMicroelectronics STM32 CRC
 
 Required properties:
-- compatible: Should be "st,stm32f7-crc".
+- compatible: Can be either "st,stm32f7-crc" or "st,srm32f4-crc".
 - reg: The address and length of the peripheral registers space
 - clocks: The input clock of the CRC instance
 
@@ -10,7 +10,7 @@ Optional properties: none
 Example:
 
 crc: crc at 40023000 {
-	compatible = "st,stm32f7-crc";
+	compatible = "st,stm32f7-crc", "st,stm32f4-crc";
 	reg = <0x40023000 0x400>;
 	clocks = <&rcc 0 12>;
 };
-- 
2.7.4
