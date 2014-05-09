From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Fri,  9 May 2014 12:27:49 +0530
Subject: [PATCH v3 3/3] ARM: vt8500: drop CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <1399618669-6830-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1399618669-6830-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <1399618669-6830-4-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch drops CONFIG_COMMON_CLK_DEBUG option
as this config option is now obsolete.

CC: Olof Johansson <olof@lixom.net>
CC: Tony Prisk <linux@prisktech.co.nz>
Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/configs/vt8500_v6_v7_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/vt8500_v6_v7_defconfig b/arch/arm/configs/vt8500_v6_v7_defconfig
index f052017..9e7a256 100644
--- a/arch/arm/configs/vt8500_v6_v7_defconfig
+++ b/arch/arm/configs/vt8500_v6_v7_defconfig
@@ -73,7 +73,6 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_VT8500=y
 CONFIG_DMADEVICES=y
-CONFIG_COMMON_CLK_DEBUG=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PWM=y
 CONFIG_PWM_VT8500=y
-- 
1.7.9.5
