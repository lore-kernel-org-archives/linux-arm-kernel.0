From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 14 Oct 2015 14:11:24 +0200
Subject: [PATCH 3/3] ARM: at91/defconfig: update sama5 defconfig
In-Reply-To: <1444824684-24526-1-git-send-email-ludovic.desroches@atmel.com>
References: <1444824684-24526-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1444824684-24526-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SAMA5D2 SoC plus Atmel flexcom and Atmel sdhci devices.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/configs/sama5_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 31eb951..6e806f5 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -15,7 +15,7 @@ CONFIG_LBDAF=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_AT91=y
-CONFIG_SOC_SAM_V7=y
+CONFIG_SOC_SAMA5D2=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
 CONFIG_AEABI=y
@@ -135,6 +135,7 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
 # CONFIG_HWMON is not set
 CONFIG_SSB=m
+CONFIG_MFD_ATMEL_FLEXCOM=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ACT8865=y
@@ -171,6 +172,9 @@ CONFIG_USB_ATMEL_USBA=y
 CONFIG_USB_G_SERIAL=y
 CONFIG_MMC=y
 # CONFIG_MMC_BLOCK_BOUNCE is not set
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_AT91=y
 CONFIG_MMC_ATMELMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
2.5.0
