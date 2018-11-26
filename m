From: pn@denx.de (Parthiban Nallathambi)
Date: Mon, 26 Nov 2018 19:58:18 +0100
Subject: [PATCH v2 1/4] dt-bindings: i2c: Add S700 support for Actions Semi
 Soc's
In-Reply-To: <20181126185821.2480449-1-pn@denx.de>
References: <20181126185821.2480449-1-pn@denx.de>
Message-ID: <20181126185821.2480449-2-pn@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add s700 compatible string to Actions Semi SoC dt-bindings.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 Documentation/devicetree/bindings/i2c/i2c-owl.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
index b743fe444e9f..dfa1197e0dbf 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-owl.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
@@ -2,7 +2,7 @@ Actions Semiconductor Owl I2C controller
 
 Required properties:
 
-- compatible        : Should be "actions,s900-i2c".
+- compatible        : Should be "actions,s700-i2c" or "actions,s900-i2c".
 - reg               : Offset and length of the register set for the device.
 - #address-cells    : Should be 1.
 - #size-cells       : Should be 0.
-- 
2.17.2
