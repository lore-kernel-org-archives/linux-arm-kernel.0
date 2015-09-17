From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:54 +0900
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Remove Marzen
In-Reply-To: <cover.1442479800.git.horms+renesas@verge.net.au>
References: <cover.1442479800.git.horms+renesas@verge.net.au>
Message-ID: <0a8b0695f4c490c349ee12956d6946576c44a419.1442479800.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kill of the defconfig bits now when the marzen-reference board code is gone.

Based on work by Magnus Damm.

Acked-by: Magnus Damm <damm@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 03deb7fb35e8..e682da3f9d42 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -85,7 +85,6 @@ CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
-CONFIG_MACH_MARZEN=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_SIRF=y
 CONFIG_ARCH_TEGRA=y
-- 
2.1.4
