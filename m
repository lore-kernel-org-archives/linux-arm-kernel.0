From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  5 Mar 2015 20:17:43 +0100
Subject: [PATCH v2 2/7] ARM: at91: switch at91_dt_defconfig to multiplatform
In-Reply-To: <1425583068-5826-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425583068-5826-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1425583068-5826-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/at91_dt_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index f2670f638e97..c944fb6e1ece 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -13,7 +13,10 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_MULTI_V4T=y
+CONFIG_ARCH_MULTI_V5=y
+# CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_SOC_SAM_V4_V5=y
 CONFIG_SOC_AT91RM9200=y
 CONFIG_SOC_AT91SAM9=y
 CONFIG_AT91_TIMER_HZ=128
-- 
2.1.0
