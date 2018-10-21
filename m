From: broonie@kernel.org (Mark Brown)
Date: Sun, 21 Oct 2018 17:59:08 +0200 (CEST)
Subject: Applied "spi: lpspi: add imx8qxp compatible string" to the spi tree
In-Reply-To: <1539886483-15775-6-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181021155908.81C2F440078@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: lpspi: add imx8qxp compatible string

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 0c903aafc8529f64d24d2cd6df32f2bf16aad20b Mon Sep 17 00:00:00 2001
From: "A.s. Dong" <aisheng.dong@nxp.com>
Date: Thu, 18 Oct 2018 18:19:34 +0000
Subject: [PATCH] spi: lpspi: add imx8qxp compatible string

Add imx8qxp compatible string

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 4af132606b37..8d178a4503cf 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible :
   - "fsl,imx7ulp-spi" for LPSPI compatible with the one integrated on i.MX7ULP soc
+  - "fsl,imx8qxp-spi" for LPSPI compatible with the one integrated on i.MX8QXP soc
 - reg : address and length of the lpspi master registers
 - interrupts : lpspi interrupt
 - clocks : lpspi clock specifier
-- 
2.19.0
