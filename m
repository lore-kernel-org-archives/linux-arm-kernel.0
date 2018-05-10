From: colin.king@canonical.com (Colin King)
Date: Thu, 10 May 2018 15:58:38 +0100
Subject: [PATCH] ASoC: zx-i2s: fix spelling mistake: "timeing" -> "timing"
Message-ID: <20180510145838.3907-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
