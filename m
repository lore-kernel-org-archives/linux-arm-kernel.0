From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 14 Mar 2014 15:43:12 +0100
Subject: [PATCH] ARM: at91: at91_dt_defconfig: select hdma controller
Message-ID: <1394808192-29987-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/configs/at91_dt_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 0b4e9b5..852028d 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -175,6 +175,7 @@ CONFIG_RTC_DRV_RV3029C2=y
 CONFIG_RTC_DRV_AT91RM9200=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
+CONFIG_AT_HDMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
-- 
1.7.9.5
