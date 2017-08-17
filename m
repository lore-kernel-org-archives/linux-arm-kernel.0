From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Aug 2017 14:09:05 +0100
Subject: [PATCH ] ARM: multi_v7_defconfig: Enable BQ32000 RTC driver
Message-ID: <1502975345-4209-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iWave RZ/G1M Q7 SOM supports RTC (TI BQ32000).
To increase hardware support enable the driver in the
multi_v7_defconfig multiplatform configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
This patch is tested against linux-next tag next-20170817 as well as 
renesas-dev tag renesas-devel-20170815-v4.13-rc5 .

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 18e1f80..02dc373 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -766,6 +766,7 @@ CONFIG_RTC_DRV_MAX8997=m
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
 CONFIG_RTC_DRV_RS5C372=m
+CONFIG_RTC_DRV_BQ32K=y
 CONFIG_RTC_DRV_PALMAS=y
 CONFIG_RTC_DRV_ST_LPC=y
 CONFIG_RTC_DRV_TWL4030=y
-- 
1.9.1
