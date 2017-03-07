From: broonie@kernel.org (Mark Brown)
Date: Tue, 07 Mar 2017 14:33:03 +0100
Subject: Applied "ASoC: pxa: Add space around '='" to the asoc tree
In-Reply-To: <1488054323-11363-1-git-send-email-codrut.cristian.grosu@gmail.com>
Message-ID: <E1clFEd-0005UD-4p@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: pxa: Add space around '='

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

>From 7be5c5fe9287c7f5cc0f2f3c742d602c82daa2d6 Mon Sep 17 00:00:00 2001
From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Date: Sat, 25 Feb 2017 22:25:23 +0200
Subject: [PATCH] ASoC: pxa: Add space around '='

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/e750_wm9705.c    | 2 +-
 sound/soc/pxa/e800_wm9712.c    | 2 +-
 sound/soc/pxa/em-x270.c        | 2 +-
 sound/soc/pxa/mioa701_wm9713.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index fdcd94adee7c..82bcbbb1841b 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -81,7 +81,7 @@ static struct snd_soc_dai_link e750_dai[] = {
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
-		.codec_dai_name ="wm9705-aux",
+		.codec_dai_name = "wm9705-aux",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9705-codec",
 	},
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 2df714f70ec0..1ed8aa2348f1 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -81,7 +81,7 @@ static struct snd_soc_dai_link e800_dai[] = {
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
-		.codec_dai_name ="wm9712-aux",
+		.codec_dai_name = "wm9712-aux",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
 	},
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index 6f2020f6c8d3..e046770ce70e 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -43,7 +43,7 @@ static struct snd_soc_dai_link em_x270_dai[] = {
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
-		.codec_dai_name ="wm9712-aux",
+		.codec_dai_name = "wm9712-aux",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
 	},
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 8760a6687885..c4c6fbedc723 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -157,7 +157,7 @@ static struct snd_soc_dai_link mioa701_dai[] = {
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
-		.codec_dai_name ="wm9713-aux",
+		.codec_dai_name = "wm9713-aux",
 		.codec_name = "wm9713-codec",
 		.platform_name = "pxa-pcm-audio",
 		.ops = &mioa701_ops,
-- 
2.11.0
