From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:53 +0900
Subject: [PATCH 1/2] ARM: shmobile: Remove Marzen from shmobile_defconfig
In-Reply-To: <cover.1442479800.git.horms+renesas@verge.net.au>
References: <cover.1442479800.git.horms+renesas@verge.net.au>
Message-ID: <ea3e4a2b3945f62457fa377c2bd0f49c32192194.1442479800.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Kill of the defconfig bits now when the marzen-reference board code is gone.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 89bf31ccfbfa..0bdeb4925be4 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -21,7 +21,6 @@ CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
-CONFIG_MACH_MARZEN=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
-- 
2.1.4
