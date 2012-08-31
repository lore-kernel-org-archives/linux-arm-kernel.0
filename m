From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Fri, 31 Aug 2012 18:20:59 +0530
Subject: [PATCH 3/3] ASoC: Davinci: evm: Fix typo in cpu dai name
In-Reply-To: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1346417459-30042-4-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix typo caused by recent commit (cf53756 - ASoC: davinci: davinci-pcm
does not need to be a plaform_driver)

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
:100644 100644 ca2a547... 2864f24... M	sound/soc/davinci/davinci-evm.c
 sound/soc/davinci/davinci-evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index ca2a547..2864f24 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -208,7 +208,7 @@ static struct snd_soc_dai_link dm365_evm_dai = {
 	.cpu_dai_name = "davinci-vcif",
 	.codec_dai_name = "cq93vc-hifi",
 	.codec_name = "cq93vc-codec",
-	.platform_name = "avinci-vcif",
+	.platform_name = "davinci-vcif",
 #endif
 };
 
-- 
1.7.1
