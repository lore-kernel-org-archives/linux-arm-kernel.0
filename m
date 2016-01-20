From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 20 Jan 2016 14:14:48 -0300
Subject: [PATCH 8/8] ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig
 symbol
In-Reply-To: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1453310088-29985-9-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver has been removed so the Kconfig symbol is not valid anymore.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>


---

 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 314f6be2dca2..bdb42c09332c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -664,7 +664,6 @@ CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_MAX8997=m
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
-CONFIG_RTC_DRV_MAX77802=m
 CONFIG_RTC_DRV_RS5C372=m
 CONFIG_RTC_DRV_PALMAS=y
 CONFIG_RTC_DRV_ST_LPC=y
-- 
2.5.0
