From: netz.kernel@gmail.com (Marty Plummer)
Date: Thu,  8 Sep 2016 12:23:42 -0500
Subject: [RFC 3/7] Make Hi3620 explicit, remove wildcards
In-Reply-To: <20160908172346.27506-1-netz.kernel@gmail.com>
References: <20160908172346.27506-1-netz.kernel@gmail.com>
Message-ID: <20160908172346.27506-3-netz.kernel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a preparatory series for adding the ARMv5/v6 hi3520 SoCs.
Assumptions were made when adding hi3620 that don't hold water in
light of adding support for the hi3520 SoC.  Fix the issue by renaming
config options and other namespaces to avoid collisions with the new
work.

Only internal APIs are modified with this series.

Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
---
 arch/arm/configs/hisi_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index b2e340b..14c8da6 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -4,7 +4,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_RD_LZMA=y
 CONFIG_ARCH_HISI=y
-CONFIG_ARCH_HI3xxx=y
+CONFIG_ARCH_HI3620=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_CMDLINE_PARTITION=y
 CONFIG_ARCH_HIX5HD2=y
-- 
2.9.3
