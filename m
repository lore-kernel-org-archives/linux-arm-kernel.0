From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 20 Nov 2012 15:18:47 +0530
Subject: [PATCH v3 5/5] ARM: OMAP2+: omap2plus_defconfig: Enable RTC support
In-Reply-To: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
Message-ID: <1353404927-14412-6-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM33XX family of devices uses RTC module, one has to manually enable
this support to use RTC features. So this patch enable RTC driver in
omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a4b330e..8839ac9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -194,6 +194,7 @@ CONFIG_SDIO_UART=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_OMAP=y
 CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_DMADEVICES=y
-- 
1.7.9.5
