From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  9 Aug 2017 12:27:39 +0100
Subject: [PATCH repost 1/2] ARM: shmobile: document iW-RainboW-G22M-SM SODIMM
 System on Module
In-Reply-To: <cover.1502274234.git.fabrizio.castro@bp.renesas.com>
References: <cover.1502274234.git.fabrizio.castro@bp.renesas.com>
Message-ID: <8e62fdff160254eb22962fea7c01af01fb269504.1502274234.git.fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the iW-RainboW-G22M-SM SODIMM System on Module device tree
bindings. It is just a placeholder for the time being, the actual
implementation is not available yet.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 275cda1..64e7f63 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -68,6 +68,8 @@ Boards:
     compatible = "renesas,h3ulcb", "renesas,r8a7795";
   - Henninger
     compatible = "renesas,henninger", "renesas,r8a7791"
+  - iWave Systems RZ/G1E SODIMM System On Module (iW-RainboW-G22M-SM)
+    compatible = "iwave,g22m", "renesas,r8a7745"
   - iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
     compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743"
   - iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
-- 
1.9.1
