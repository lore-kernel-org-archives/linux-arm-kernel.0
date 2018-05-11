From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 May 2018 03:55:15 +0100 (BST)
Subject: Applied "ASoC: zx-i2s: fix spelling mistake: "timeing" -> "timing""
 to the asoc tree
Message-ID: <20180511025516.0816E440084@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: zx-i2s: fix spelling mistake: "timeing" -> "timing"

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

>From d165b5a86fcad715aea1f164186224fe0c2f57f3 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 10 May 2018 15:58:38 +0100
Subject: [PATCH] ASoC: zx-i2s: fix spelling mistake: "timeing" -> "timing"

Trivial fix to spelling mistake in dev_err message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/zx-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index 9a0565937d1f..b6b056c607fa 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -197,7 +197,7 @@ static int zx_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		val |= (ZX_I2S_TIMING_I2S | ZX_I2S_TIMING_LSB_JUSTIF);
 		break;
 	default:
-		dev_err(cpu_dai->dev, "Unknown i2s timeing\n");
+		dev_err(cpu_dai->dev, "Unknown i2s timing\n");
 		return -EINVAL;
 	}
 
-- 
2.17.0
