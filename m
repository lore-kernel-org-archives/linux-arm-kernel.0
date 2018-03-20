From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Mar 2018 07:16:19 -0700
Subject: [PATCH 2/5] ARM: omap2plus_defconfig: Add AUDIO_GRAPH_CARD
In-Reply-To: <20180320141622.77989-1-tony@atomide.com>
References: <20180320141622.77989-1-tony@atomide.com>
Message-ID: <20180320141622.77989-3-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed for audio on droid 4.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -387,7 +387,9 @@ CONFIG_SND_OMAP_SOC_HDMI_AUDIO=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
+CONFIG_SND_SOC_CPCAP=m
 CONFIG_SND_SIMPLE_CARD=m
+CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_HID_GENERIC=m
 CONFIG_USB_HIDDEV=y
 CONFIG_USB_KBD=m
-- 
2.16.2
