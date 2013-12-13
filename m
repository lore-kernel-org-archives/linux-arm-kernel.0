From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:02 +0900
Subject: [PATCH 29/33] ARM: shmobile: Select AUTO_ZRELADDR for EMEV2
In-Reply-To: <cover.1386897180.git.horms+renesas@verge.net.au>
References: <cover.1386897180.git.horms+renesas@verge.net.au>
Message-ID: <42a1ba525dd74552f68f3aee0756d16987ad719e.1386897180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ("ARM: shmobile: Remove legacy KZM9D board code")
It is now necessary for AUTO_ZRELADDR to be selected
in order for the kernel to build with kzm9d_defconfig.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 1b7df17..aa9017b 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -113,6 +113,7 @@ config ARCH_EMEV2
 	select ARM_GIC
 	select CPU_V7
 	select USE_OF
+	select AUTO_ZRELADDR
 
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
-- 
1.8.4
