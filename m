From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 May 2011 21:55:38 +0800
Subject: [PATCH 1/2] ARM: mxs_defconfig: Change CONFIG_RTC_CLASS 'm' to 'y'
Message-ID: <1306331739-8241-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch fixes the warning below.

arch/arm/configs/mxs_defconfig:92:warning: symbol value 'm' invalid for RTC_CLASS

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/mxs_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 2bf2243..5a6ff7c 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -89,7 +89,7 @@ CONFIG_DISPLAY_SUPPORT=m
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_MXS=y
-CONFIG_RTC_CLASS=m
+CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=m
 CONFIG_DMADEVICES=y
 CONFIG_MXS_DMA=y
-- 
1.7.4.1
