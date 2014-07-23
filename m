From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 23 Jul 2014 22:38:58 +0800
Subject: [PATCH v2 6/6] ARM: sunxi: Add A31 RTC driver to multi_v7_defconfig
In-Reply-To: <1406126338-15062-1-git-send-email-wens@csie.org>
References: <1406126338-15062-1-git-send-email-wens@csie.org>
Message-ID: <1406126338-15062-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a driver for A31's RTC, enable it
in multi_v7_defconfig.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a62ca27..130dd8d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -346,6 +346,7 @@ CONFIG_RTC_DRV_TPS65910=y
 CONFIG_RTC_DRV_EM3027=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_VT8500=y
+CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_RTC_DRV_TEGRA=y
-- 
2.0.1
