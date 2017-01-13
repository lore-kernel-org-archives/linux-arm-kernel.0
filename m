From: david@lechnology.com (David Lechner)
Date: Fri, 13 Jan 2017 13:03:41 -0600
Subject: [PATCH v4 3/4] dt-bindings: add "microchip,24c128" compatible string
In-Reply-To: <1484334222-14223-1-git-send-email-david@lechnology.com>
References: <1484334222-14223-1-git-send-email-david@lechnology.com>
Message-ID: <1484334222-14223-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds "microchip,24c128" to the list of compatible strings for i2c
eeproms.

Signed-off-by: David Lechner <david@lechnology.com>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index 735bc94..5696eb5 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -10,6 +10,8 @@ Required properties:
 
 	"catalyst,24c32"
 
+	"microchip,24c128"
+
 	"ramtron,24c64"
 
 	"renesas,r1ex24002"
-- 
2.7.4
