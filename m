From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 21 Jan 2016 17:23:33 -0300
Subject: [PATCH v2 10/10] ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig
 symbol
In-Reply-To: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
References: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1453407813-14646-11-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver has been removed so the Kconfig symbol is not valid anymore.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


---

Changes in v2:
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #10.

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
