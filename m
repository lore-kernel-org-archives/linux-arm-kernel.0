From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2012 13:38:18 +0900
Subject: [PATCH 2/2] ARM: shmobile: armadillo800eva: enable L2X0 cache on
 defconfig
In-Reply-To: <1350448698-26985-1-git-send-email-horms@verge.net.au>
References: <1350448698-26985-1-git-send-email-horms@verge.net.au>
Message-ID: <1350448698-26985-3-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index f78d259..a18593d 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -20,7 +20,7 @@ CONFIG_MACH_ARMADILLO800EVA=y
 # CONFIG_SH_TIMER_TMU is not set
 CONFIG_ARM_THUMB=y
 CONFIG_CPU_BPREDICT_DISABLE=y
-# CONFIG_CACHE_L2X0 is not set
+CONFIG_CACHE_L2X0=y
 CONFIG_ARM_ERRATA_430973=y
 CONFIG_ARM_ERRATA_458693=y
 CONFIG_ARM_ERRATA_460075=y
-- 
1.7.10.4
