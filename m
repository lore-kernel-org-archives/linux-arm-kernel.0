From: jsarha@ti.com (Jyri Sarha)
Date: Tue, 19 Nov 2013 14:12:29 +0200
Subject: [PATCH RFC 9/9] ARM: OMAP2+: omap2plus_defconfig: Enable BeagleBone
 Black HDMI audio support
In-Reply-To: <cover.1384862950.git.jsarha@ti.com>
References: <cover.1384862950.git.jsarha@ti.com>
Message-ID: <0e074a96e1a3f1817bf597f8c98724575dad9f18.1384862950.git.jsarha@ti.com>
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
index 52b0d92..c1a9730 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -216,6 +216,8 @@ CONFIG_SND_OMAP_SOC=m
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
