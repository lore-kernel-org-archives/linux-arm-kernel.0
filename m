From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:29:46 +0900
Subject: [PATCH 05/33] ARM: shmobile: Select GPIO in case of the r8a7791 SoC
In-Reply-To: <cover.1386897180.git.horms+renesas@verge.net.au>
References: <cover.1386897180.git.horms+renesas@verge.net.au>
Message-ID: <cc3a17d799481c502485d8c0770b888c3b4d788d.1386897180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Make it possible to build GPIO on r8a7791.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index ff7c4ce..4e1cc76 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -97,6 +97,7 @@ config ARCH_R8A7790
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
-- 
1.8.4
