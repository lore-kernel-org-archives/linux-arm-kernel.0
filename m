From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Wed, 24 Dec 2014 17:23:35 +0800
Subject: [PATCH v5 1/2] ARM: hip04: add GPIO configure in hisi_defconfig
In-Reply-To: <1419413016-31932-1-git-send-email-wangzhou.bry@gmail.com>
References: <1419413016-31932-1-git-send-email-wangzhou.bry@gmail.com>
Message-ID: <1419413016-31932-2-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO controller of Hisilicon hip04 Soc uses the IP from Sysnopsis,
gpio-dwapb.c can be reused to support this GPIO controller. This patch
adds related configure item in hisi_defconfig.

Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
---
 arch/arm/configs/hisi_defconfig |    1 +
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
1.7.9.5
