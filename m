From: cosardindar@gmail.com (Cosar Dindar)
Date: Mon, 17 Jul 2017 11:27:14 +0300
Subject: [RESEND,
 PATCH v4 2/3] dt-bindings : Document the STM32F4 CRC32 binding
Message-ID: <1500280034-46193-1-git-send-email-cosardindar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding for STM32F4.

Signed-off-by: Cosar Dindar <cosardindar@gmail.com>
---
 Documentation/devicetree/bindings/crypto/st,stm32-crc.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt b/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
index 3ba92a5..1e9af69 100644
--- a/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
+++ b/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
@@ -1,7 +1,9 @@
 * STMicroelectronics STM32 CRC
 
 Required properties:
-- compatible: Should be "st,stm32f7-crc".
+- compatible: Should be one of the following string.
+	      "st,stm32f7-crc"
+	      "st,stm32f4-crc"
 - reg: The address and length of the peripheral registers space
 - clocks: The input clock of the CRC instance
 
-- 
2.7.4
