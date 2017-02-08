From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Thu,  9 Feb 2017 00:30:05 +0100 (CET)
Subject: [PATCH v2 1/5] dts: mfd: axp20x: Add AXP806 to list of current AXP20x
 family members
In-Reply-To: <cover.1486592470.git.rask@formelder.dk>
References: <cover.1486592470.git.rask@formelder.dk>
Message-ID: <fd2101870941430d82798cdde64644d5e3d49f70.1486592471.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An entry for the AXP806 was forgotten, so add one.

Fixes: 204ae2963e10 ("mfd: axp20x: Add bindings for AXP806 PMIC")
Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
---

No changes in v2.

 Documentation/devicetree/bindings/mfd/axp20x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 8f3ad9a..86ae540 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -6,6 +6,7 @@ axp202 (X-Powers)
 axp209 (X-Powers)
 axp221 (X-Powers)
 axp223 (X-Powers)
+axp806 (X-Powers)
 axp809 (X-Powers)
 
 Required properties:
-- 
2.10.2
