From: broonie@kernel.org (Mark Brown)
Date: Mon, 04 Jul 2016 10:58:40 +0200
Subject: Applied "ASoC: bt-sco: add config prompt" to the asoc tree
In-Reply-To: <1467616002-10447-1-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <E1bJziC-0004QM-4E@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: bt-sco: add config prompt

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

>From 8b0b50d8a3e3ccfa4632a227102b97994ed95fc0 Mon Sep 17 00:00:00 2001
From: Garlic Tseng <garlic.tseng@mediatek.com>
Date: Mon, 4 Jul 2016 15:06:42 +0800
Subject: [PATCH] ASoC: bt-sco: add config prompt

Add config prompt for bt-sco codec driver

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4d82a58ff6b0..3ba998a79165 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -371,7 +371,7 @@ config SND_SOC_ALC5632
 	tristate
 
 config SND_SOC_BT_SCO
-	tristate
+	tristate "Dummy BT SCO codec driver"
 
 config SND_SOC_CQ0093VC
 	tristate
-- 
2.8.1
