From: broonie@kernel.org (Mark Brown)
Date: Mon,  5 Nov 2018 12:05:55 +0000 (GMT)
Subject: Applied "spi: mediatek: Add bindings for mediatek MT8183 soc
 platform" to the spi tree
In-Reply-To: <1541052139-8845-2-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20181105120555.D73F21124D98@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: mediatek: Add bindings for mediatek MT8183 soc platform

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

>From f611dfdb8544b5ac4228f4e3cb3b06ce15b9c74b Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Thu, 1 Nov 2018 14:02:18 +0800
Subject: [PATCH] spi: mediatek: Add bindings for mediatek MT8183 soc platform

This patch adds a DT binding documentation for the MT8183 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 236dcb0faf37..7940940b43e6 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -8,6 +8,7 @@ Required properties:
     - mediatek,mt7622-spi: for mt7622 platforms
     - mediatek,mt8135-spi: for mt8135 platforms
     - mediatek,mt8173-spi: for mt8173 platforms
+    - mediatek,mt8183-spi: for mt8183 platforms
 
 - #address-cells: should be 1.
 
-- 
2.19.0.rc2
