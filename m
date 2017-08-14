From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 14 Aug 2017 12:39:26 +0100
Subject: [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
Message-ID: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5) SDHI
is identical to the R-Car Gen2 family.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
This patch is compiled and tested againt linux next tag
next-20170811. This patch depend on the driver change
[PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
https://patchwork.kernel.org/patch/9898611/


 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 4fd8b7a..0d507ec 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -15,6 +15,8 @@ Required properties:
 		"renesas,sdhi-r7s72100" - SDHI IP on R7S72100 SoC
 		"renesas,sdhi-r8a73a4" - SDHI IP on R8A73A4 SoC
 		"renesas,sdhi-r8a7740" - SDHI IP on R8A7740 SoC
+		"renesas,sdhi-r8a7743" - SDHI IP on R8A7743 SoC
+		"renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
 		"renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
 		"renesas,sdhi-r8a7779" - SDHI IP on R8A7779 SoC
 		"renesas,sdhi-r8a7790" - SDHI IP on R8A7790 SoC
@@ -34,8 +36,8 @@ Required properties:
 	  "core" and "cd". If the controller only has 1 clock, naming is not
 	  required.
 	  Below is the number clocks for each supported SoC:
-	   1: SH73A0, R8A73A4, R8A7740, R8A7778, R8A7779, R8A7790
-	      R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
+	   1: SH73A0, R8A73A4, R8A7740, R8A7743, R8A7745, R8A7778, R8A7779,
+	      R8A7790, R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
 	   2: R7S72100
 
 Optional properties:
-- 
1.9.1
