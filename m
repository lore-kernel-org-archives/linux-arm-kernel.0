From: jsarha@ti.com (Jyri Sarha)
Date: Mon, 27 Jan 2014 17:37:57 +0200
Subject: [PATCH RFC v3 8/8] ARM: OMAP2+: omap2plus_defconfig: Enable
 BeagleBone Black HDMI audio support
In-Reply-To: <cover.1390836773.git.jsarha@ti.com>
References: <cover.1390836773.git.jsarha@ti.com>
Message-ID: <7bb9708316dc4f8e68c4b36dafa5a0432a232da8.1390836773.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select following:
CONFIG_SND_DAVINCI_SOC=m
CONFIG_SND_AM335X_SOC_NXPTDA_EVM=m

Signed-off-by: Jyri Sarha <jsarha@ti.com>
cc: tony at atomide.com
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9288172..62c4f51 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -214,6 +214,8 @@ CONFIG_SND_OMAP_SOC=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
+CONFIG_SND_DAVINCI_SOC=m
+CONFIG_SND_AM335X_SOC_NXPTDA_EVM=m
 CONFIG_USB=y
 CONFIG_USB_DEBUG=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-- 
1.7.9.5
