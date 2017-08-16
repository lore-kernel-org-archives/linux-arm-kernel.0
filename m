From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 16 Aug 2017 12:12:16 +0100
Subject: [PATCH ] gpio: rcar: Add r8a7745 (RZ/G1E) support
Message-ID: <1502881936-39357-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renesas RZ/G1E (R8A7745) SoC GPIO blocks are identical to the R-Car Gen2
family. Add support for its GPIO controllers.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
This patch is tested against linux-next tag next-20170816 as well as gpio-devel.

 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index 48634b0..51c86f6 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -4,6 +4,7 @@ Required Properties:
 
   - compatible: should contain one or more of the following:
     - "renesas,gpio-r8a7743": for R8A7743 (RZ/G1M) compatible GPIO controller.
+    - "renesas,gpio-r8a7745": for R8A7745 (RZ/G1E) compatible GPIO controller.
     - "renesas,gpio-r8a7778": for R8A7778 (R-Mobile M1) compatible GPIO controller.
     - "renesas,gpio-r8a7779": for R8A7779 (R-Car H1) compatible GPIO controller.
     - "renesas,gpio-r8a7790": for R8A7790 (R-Car H2) compatible GPIO controller.
-- 
1.9.1
