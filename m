From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Wed, 25 Mar 2015 14:57:44 +0800
Subject: [RESEND PATCH v6 1/2] ARM: hip04: add GPIO configure in hisi_defconfig
In-Reply-To: <1427266665-226718-1-git-send-email-wangzhou1@hisilicon.com>
References: <1427266665-226718-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <1427266665-226718-2-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhou Wang <wangzhou.bry@gmail.com>

The GPIO controller of Hisilicon hip04 Soc uses the IP from Sysnopsis,
gpio-dwapb.c can be reused to support this GPIO controller. This patch
adds related configure item in hisi_defconfig.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 arch/arm/configs/hisi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index c34da58..e7bf486 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -51,6 +51,7 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_GPIO_DWAPB=y
 CONFIG_MFD_SYSCON=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_DRM=y
-- 
1.9.1
