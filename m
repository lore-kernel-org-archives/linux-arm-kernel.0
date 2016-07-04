From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Mon, 4 Jul 2016 15:06:42 +0800
Subject: [alsa-devel] [PATCH] ASoC: bt-sco: add config prompt
Message-ID: <1467616002-10447-1-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add config prompt for bt-sco codec driver

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f2f8603..1cd6ab3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -383,7 +383,7 @@ config SND_SOC_ALC5632
 	tristate
 
 config SND_SOC_BT_SCO
-	tristate
+	tristate "Dummy BT SCO codec driver"
 
 config SND_SOC_CQ0093VC
 	tristate
-- 
1.9.1
