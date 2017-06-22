From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Jun 2017 12:08:28 +0800
Subject: [PATCH 1/6] dt-bindings: mfd: axp20x: Add AXP806 to supported list of
 chips
In-Reply-To: <20170622040833.15329-1-wens@csie.org>
References: <20170622040833.15329-1-wens@csie.org>
Message-ID: <20170622040833.15329-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding already lists compatibles and regulators for the AXP806,
but it is missing from the list of supported chips at the beginning.

Add it.

Fixes: 204ae2963e10 ("mfd: axp20x: Add bindings for AXP806 PMIC")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index aca09af66514..211a100c6b20 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -7,6 +7,7 @@ axp209 (X-Powers)
 axp221 (X-Powers)
 axp223 (X-Powers)
 axp803 (X-Powers)
+axp806 (X-Powers)
 axp809 (X-Powers)
 
 Required properties:
-- 
2.11.0
