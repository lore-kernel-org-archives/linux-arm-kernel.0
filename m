From: cosardindar@gmail.com (Cosar Dindar)
Date: Fri,  2 Jun 2017 17:27:07 +0300
Subject: [PATCH v4] dt-bindings : Fix binding properties
Message-ID: <640b6a7409ed85ea07c19bac6fea707ed80b47c0.1496413070.git.cosardindar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Binding properties explanation has been updated.

Signed-off-by: Cosar Dindar <cosardindar@gmail.com>
---
 Documentation/devicetree/bindings/crypto/st,stm32-crc.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt b/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
index 7b30f1e..1e9af69 100644
--- a/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
+++ b/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
@@ -1,7 +1,9 @@
 * STMicroelectronics STM32 CRC
 
 Required properties:
-- compatible: Can be either "st,stm32f7-crc" or "st,srm32f4-crc".
+- compatible: Should be one of the following string.
+	      "st,stm32f7-crc"
+	      "st,stm32f4-crc"
 - reg: The address and length of the peripheral registers space
 - clocks: The input clock of the CRC instance
 
@@ -10,7 +12,7 @@ Optional properties: none
 Example:
 
 crc: crc at 40023000 {
-	compatible = "st,stm32f7-crc", "st,stm32f4-crc";
+	compatible = "st,stm32f7-crc";
 	reg = <0x40023000 0x400>;
 	clocks = <&rcc 0 12>;
 };
-- 
2.7.4
