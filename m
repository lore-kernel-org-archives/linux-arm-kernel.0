From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 16 Oct 2015 15:04:48 +0200
Subject: [PATCH v2 5/8] ARM: at91/defconfig: add sama5d2 and its new devices
 to sama5 defconfig
In-Reply-To: <1445000691-12402-1-git-send-email-ludovic.desroches@atmel.com>
References: <1445000691-12402-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1445000691-12402-6-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SAMA5D2 SoC plus Atmel flexcom and Atmel sdhci devices.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/configs/sama5_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 3b2f686..a0c57ac 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -14,6 +14,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_AT91=y
+CONFIG_SOC_SAMA5D2=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
 CONFIG_AEABI=y
@@ -129,6 +130,7 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
 # CONFIG_HWMON is not set
 CONFIG_SSB=m
+CONFIG_MFD_ATMEL_FLEXCOM=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ACT8865=y
@@ -165,6 +167,9 @@ CONFIG_USB_ATMEL_USBA=y
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
