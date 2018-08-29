From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Wed, 29 Aug 2018 19:47:55 +0300
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: add Atmel I2S driver
In-Reply-To: <20180829164755.4690-1-codrin.ciubotariu@microchip.com>
References: <20180829164755.4690-1-codrin.ciubotariu@microchip.com>
Message-ID: <20180829164755.4690-2-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add atmel-i2s driver CONFIG_SND_ATMEL_SOC_I2S.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fc33444e94f0..037a19d9802f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -650,6 +650,7 @@ CONFIG_SND_SOC=m
 CONFIG_SND_ATMEL_SOC=m
 CONFIG_SND_ATMEL_SOC_WM8904=m
 CONFIG_SND_ATMEL_SOC_PDMIC=m
+CONFIG_SND_ATMEL_SOC_I2S=m
 CONFIG_SND_BCM2835_SOC_I2S=m
 CONFIG_SND_SOC_FSL_SAI=m
 CONFIG_SND_SOC_ROCKCHIP=m
-- 
2.17.1
