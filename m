From: broonie@kernel.org (Mark Brown)
Date: Tue, 06 Jun 2017 20:07:14 +0100
Subject: Applied "spi: mediatek: Add bindings for mediatek MT7622 soc
 platform" to the spi tree
In-Reply-To: <1496387923-31674-2-git-send-email-leilk.liu@mediatek.com>
Message-ID: <E1dIJow-0007ZA-UM@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: mediatek: Add bindings for mediatek MT7622 soc platform

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

>From d27ae103bf89a0ed28976da58a8f5e1c4c85ecb5 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Fri, 2 Jun 2017 15:18:41 +0800
Subject: [PATCH] spi: mediatek: Add bindings for mediatek MT7622 soc platform

This patch adds a DT binding documentation for the MT7622 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index e43f4cf4cf35..c0b1f0134390 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: should be one of the following.
     - mediatek,mt2701-spi: for mt2701 platforms
     - mediatek,mt6589-spi: for mt6589 platforms
+    - mediatek,mt7622-spi: for mt7622 platforms
     - mediatek,mt8135-spi: for mt8135 platforms
     - mediatek,mt8173-spi: for mt8173 platforms
 
-- 
2.11.0
