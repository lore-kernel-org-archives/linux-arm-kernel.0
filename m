From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Apr 2018 15:19:24 +0100
Subject: Applied "ASoC: mediatek: add MT7622 AFE compatible in documentation"
 to the asoc tree
In-Reply-To: <43bf5fcef0edefef2524122e64400785243f4fdf.1524628914.git.ryder.lee@mediatek.com>
Message-ID: <E1fBhk4-00042f-DB@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: add MT7622 AFE compatible in documentation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From eaeb4194de9c843742f421daa858f27e7c89a625 Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Wed, 25 Apr 2018 12:19:58 +0800
Subject: [PATCH] ASoC: mediatek: add MT7622 AFE compatible in documentation

Add support for MT7622 AFE which shares the same binding with MT2701.

Cc: devicetree at vger.kernel.org
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index e2f7f4951215..560762e0a168 100644
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
@@ -1,7 +1,9 @@
 Mediatek AFE PCM controller for mt2701
 
 Required properties:
-- compatible = "mediatek,mt2701-audio";
+- compatible: should be one of the followings.
+	      - "mediatek,mt2701-audio"
+	      - "mediatek,mt7622-audio"
 - interrupts: should contain AFE and ASYS interrupts
 - interrupt-names: should be "afe" and "asys"
 - power-domains: should define the power domain
-- 
2.17.0
