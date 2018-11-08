From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 8 Nov 2018 10:37:53 +0200
Subject: [RFC 8/9] ARM: davinci_all_defconfig: Update the audio options
In-Reply-To: <20181108083754.1746-1-peter.ujfalusi@ti.com>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
Message-ID: <20181108083754.1746-9-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new options for default audio support.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/configs/davinci_all_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 07b2eadac3dd..207962a656a2 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -167,8 +167,9 @@ CONFIG_SOUND=m
 CONFIG_SND=m
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
-CONFIG_SND_EDMA_SOC=m
-CONFIG_SND_DA850_SOC_EVM=m
+CONFIG_SND_SOC_TLV320AIC3X=m
+CONFIG_SND_SOC_DAVINCI_MCASP=m
+CONFIG_SND_SOC_DAVINCI_EVM=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_HID=m
 CONFIG_HID_A4TECH=m
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
