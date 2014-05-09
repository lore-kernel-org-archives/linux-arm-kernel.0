From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Fri,  9 May 2014 12:27:48 +0530
Subject: [PATCH v3 2/3] ARM: sunxi: drop CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <1399618669-6830-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1399618669-6830-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <1399618669-6830-3-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch drops CONFIG_COMMON_CLK_DEBUG option
as this config option is now obsolete.

CC: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Olof Johansson <olof@lixom.net>
Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/configs/sunxi_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index b5df4a5..28287ae 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -62,7 +62,6 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
-CONFIG_COMMON_CLK_DEBUG=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
-- 
1.7.9.5
