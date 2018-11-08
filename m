From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 8 Nov 2018 10:37:51 +0200
Subject: [RFC 6/9] ARM: omap2plus_defconfig: Update the audio options
In-Reply-To: <20181108083754.1746-1-peter.ujfalusi@ti.com>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
Message-ID: <20181108083754.1746-7-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new options for default audio support and enable Nokia n900 audio
as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 21cabb7ad970..9c6f436d1b12 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -381,13 +381,13 @@ CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
-CONFIG_SND_EDMA_SOC=m
-CONFIG_SND_AM33XX_SOC_EVM=m
-CONFIG_SND_OMAP_SOC=m
-CONFIG_SND_OMAP_SOC_HDMI_AUDIO=m
-CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
-CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
-CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
+CONFIG_SND_SOC_TLV320AIC3X=m
+CONFIG_SND_SOC_DAVINCI_MCASP=m
+CONFIG_SND_SOC_NOKIA_RX51=m
+CONFIG_SND_SOC_OMAP_HDMI=m
+CONFIG_SND_SOC_OMAP_ABE_TWL6040=m
+CONFIG_SND_SOC_OMAP3_PANDORA=m
+CONFIG_SND_SOC_OMAP3_TWL4030=m
 CONFIG_SND_SOC_CPCAP=m
 CONFIG_SND_SOC_TLV320AIC23_I2C=m
 CONFIG_SND_SIMPLE_CARD=m
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
