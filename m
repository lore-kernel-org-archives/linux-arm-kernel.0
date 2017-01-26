From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Thu, 26 Jan 2017 22:23:41 +0100 (CET)
Subject: [PATCH 1/5] DT: mfd: axp20x: Add AXP806 to list of current AXP20x
 family members
In-Reply-To: <cover.1485456003.git.rask@formelder.dk>
References: <cover.1485456003.git.rask@formelder.dk>
Message-ID: <abdfbac9a5f363ab6d338dd66d8fb138741f71c7.1485456005.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An entry for the AXP806 was forgotten, so add one.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
Fixes: 204ae2963e10 ("mfd: axp20x: Add bindings for AXP806 PMIC")
---
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
