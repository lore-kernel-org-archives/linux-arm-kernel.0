From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Sep 2015 12:00:04 +0200
Subject: [PATCH 1/3] ALSA: hda/hdmi - Add missing MODALIAS information
In-Reply-To: <1442484006-9614-1-git-send-email-thierry.reding@gmail.com>
References: <1442484006-9614-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1442484006-9614-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add MODALIAS definitions for the Tegra30 HDMI, Tegra114 HDMI and
Tegra210 HDMI/DP codecs. The preset match table already contains
corresponding entries, but the MODALIAS list wasn't updated.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index acbfbe087ee8..70f7d873e65e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3585,7 +3585,10 @@ MODULE_ALIAS("snd-hda-codec-id:10de0019");
 MODULE_ALIAS("snd-hda-codec-id:10de001a");
 MODULE_ALIAS("snd-hda-codec-id:10de001b");
 MODULE_ALIAS("snd-hda-codec-id:10de001c");
+MODULE_ALIAS("snd-hda-codec-id:10de0020");
+MODULE_ALIAS("snd-hda-codec-id:10de0022");
 MODULE_ALIAS("snd-hda-codec-id:10de0028");
+MODULE_ALIAS("snd-hda-codec-id:10de0029");
 MODULE_ALIAS("snd-hda-codec-id:10de0040");
 MODULE_ALIAS("snd-hda-codec-id:10de0041");
 MODULE_ALIAS("snd-hda-codec-id:10de0042");
-- 
2.5.0
