From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Aug 2017 11:49:27 +0200
Subject: [PATCH] ARM: shmobile: Enable BQ32000 rtc in shmobile_defconfig
In-Reply-To: <cover.1502960320.git.horms+renesas@verge.net.au>
References: <cover.1502960320.git.horms+renesas@verge.net.au>
Message-ID: <0736aad1290d61bc3668f20253e1e1997ad8b3c1.1502960320.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

The iWave RZ/G1M Q7 SOM supports RTC (TI BQ32000).
To increase hardware support enable the driver in the
shmobile_defconfig multiplatform configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 18886c53424a..7b4fc0143148 100644
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
2.1.4
