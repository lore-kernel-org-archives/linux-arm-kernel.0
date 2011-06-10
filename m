From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 10 Jun 2011 12:04:27 +0530
Subject: [PATCH 5/5] ASoC: SMDKV310: Enable SPDIF device
In-Reply-To: <1307687667-9127-1-git-send-email-ch.naveen@samsung.com>
References: <1307687667-9127-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1307687667-9127-6-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 sound/soc/samsung/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index d155cbb..92236eb 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -158,7 +158,7 @@ config SND_SOC_GONI_AQUILA_WM8994
 
 config SND_SOC_SAMSUNG_SMDK_SPDIF
 	tristate "SoC S/PDIF Audio support for SMDK"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210)
+	depends on SND_SOC_SAMSUNG && (MACH_SMDKC100 || MACH_SMDKC110 || MACH_SMDKV210 || MACH_SMDKV310)
 	select SND_SAMSUNG_SPDIF
 	help
 	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
-- 
1.7.2.3
