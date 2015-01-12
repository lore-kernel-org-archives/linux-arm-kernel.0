From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Mon, 12 Jan 2015 15:05:11 +0800
Subject: [PATCH v6 1/2] ARM: hip04: add GPIO configure in hisi_defconfig
In-Reply-To: <1421046312-22170-1-git-send-email-wangzhou1@hisilicon.com>
References: <1421046312-22170-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <1421046312-22170-2-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO controller of Hisilicon hip04 Soc uses the IP from Sysnopsis,
gpio-dwapb.c can be reused to support this GPIO controller. This patch
adds related configure item in hisi_defconfig.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 arch/arm/configs/hisi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index 1125436..4a50862 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -50,6 +50,7 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_GPIO_DWAPB=y
 CONFIG_MFD_SYSCON=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_DRM=y
-- 
1.9.1
