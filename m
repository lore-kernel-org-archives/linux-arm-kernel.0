From: kbeldan@baylibre.com (Karl Beldan)
Date: Wed, 10 Aug 2016 20:08:53 +0000
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: enable modules for sound on
 LCDK
In-Reply-To: <20160810200853.24275-1-kbeldan@baylibre.com>
References: <20160810200853.24275-1-kbeldan@baylibre.com>
Message-ID: <20160810200853.24275-2-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the minimal set of additional modules required to support audio
on the LCDK.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 9980d1d..0357e39 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -128,6 +128,10 @@ CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
 CONFIG_SND_SOC=m
+CONFIG_SND_EDMA_SOC=m
+CONFIG_SND_DAVINCI_SOC_MCASP=m
+CONFIG_SND_SOC_TLV320AIC3X=m
+CONFIG_SND_SIMPLE_CARD=m
 CONFIG_HID=m
 CONFIG_HID_A4TECH=m
 CONFIG_HID_APPLE=m
-- 
2.9.2
