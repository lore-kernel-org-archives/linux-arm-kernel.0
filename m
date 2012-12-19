From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 19 Dec 2012 13:33:39 +0100
Subject: [PATCH 1/2] ARM: OMAP2+: omap2plus_defconfig: enable TFP410 chip
 support
Message-ID: <1355920420-20852-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many OMAP3 based boards such as Beagle, Overo and IGEP use
the TFP410 DPI-to-DVI chip. So, it's good to have it built
as a module by default on OMAP2+ config.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a1dc5c0..da530a0 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -146,6 +146,7 @@ CONFIG_OMAP2_DSS_SDI=y
 CONFIG_OMAP2_DSS_DSI=y
 CONFIG_FB_OMAP2=m
 CONFIG_PANEL_GENERIC_DPI=m
+CONFIG_PANEL_TFP410=m
 CONFIG_PANEL_SHARP_LS037V7DW01=m
 CONFIG_PANEL_NEC_NL8048HL11_01B=m
 CONFIG_PANEL_TAAL=m
-- 
1.7.7.6
