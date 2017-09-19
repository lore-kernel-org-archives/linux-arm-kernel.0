From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Sep 2017 14:47:29 +0100
Subject: Applied "spi: rspi: Add r8a7743/5 to the compatible list" to the spi
 tree
In-Reply-To: <1504858035-3568-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <E1duIs5-0008U8-I2@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rspi: Add r8a7743/5 to the compatible list

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 10c1705eced11d6ad710fddcdb57aaa9f85a6f98 Mon Sep 17 00:00:00 2001
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Date: Fri, 8 Sep 2017 09:07:15 +0100
Subject: [PATCH] spi: rspi: Add r8a7743/5 to the compatible list

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
index 8f4169f63936..3b02b3a7cfb2 100644
--- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -5,11 +5,14 @@ Required properties:
 		     "renesas,rspi-<soctype>", "renesas,rspi" as fallback.
 		     For Renesas Serial Peripheral Interface on RZ/A1H:
 		     "renesas,rspi-<soctype>", "renesas,rspi-rz" as fallback.
-		     For Quad Serial Peripheral Interface on R-Car Gen2:
+		     For Quad Serial Peripheral Interface on R-Car Gen2 and
+		     RZ/G1 devices:
 		     "renesas,qspi-<soctype>", "renesas,qspi" as fallback.
 		     Examples with soctypes are:
 		        - "renesas,rspi-sh7757" (SH)
 			- "renesas,rspi-r7s72100" (RZ/A1H)
+			- "renesas,qspi-r8a7743" (RZ/G1M)
+			- "renesas,qspi-r8a7745" (RZ/G1E)
 			- "renesas,qspi-r8a7790" (R-Car H2)
 			- "renesas,qspi-r8a7791" (R-Car M2-W)
 			- "renesas,qspi-r8a7792" (R-Car V2H)
-- 
2.14.1
