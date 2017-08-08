From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  8 Aug 2017 14:04:25 +0100
Subject: [PATCH  2/2] ARM: shmobile: Enable BQ32000 rtc in shmobile_defconfig
In-Reply-To: <1502197465-61546-1-git-send-email-biju.das@bp.renesas.com>
References: <1502197465-61546-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502197465-61546-3-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iWave RZ/G1M Q7 SOM supports RTC (TI BQ32000).
To increase hardware support enable the driver in the
shmobile_defconfig multiplatform configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 18886c5..7b4fc01 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -193,6 +193,7 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
+CONFIG_RTC_DRV_BQ32K=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_RX8581=y
 CONFIG_RTC_DRV_DA9063=y
-- 
1.9.1
