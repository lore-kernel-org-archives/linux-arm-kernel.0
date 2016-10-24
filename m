From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Oct 2016 19:04:34 +0100
Subject: Applied "ASoC: davinci-mcbsp: DT fix
 s/interrupts-names/interrupt-names/" to the asoc tree
In-Reply-To: <1477039877-20227-5-git-send-email-geert+renesas@glider.be>
Message-ID: <E1byjbu-0001Tg-U9@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: davinci-mcbsp: DT fix s/interrupts-names/interrupt-names/

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From a545f5d859c7988ab61850395a4565bfe507dc0a Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 21 Oct 2016 10:51:15 +0200
Subject: [PATCH] ASoC: davinci-mcbsp: DT fix
 s/interrupts-names/interrupt-names/

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
index 55b53e1fd72c..e0b6165c9cfc 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
@@ -43,7 +43,7 @@ mcbsp0: mcbsp at 1d10000 {
 		<0x00310000 0x1000>;
 	reg-names = "mpu", "dat";
 	interrupts = <97 98>;
-	interrupts-names = "rx", "tx";
+	interrupt-names = "rx", "tx";
 	dmas = <&edma0 3 1
 		&edma0 2 1>;
 	dma-names = "tx", "rx";
-- 
2.8.1
