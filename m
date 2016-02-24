From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Feb 2016 10:21:17 +0900
Subject: [PATCH 2/2] ARM: shmobile: Kconfig: Get rid of old comment
In-Reply-To: <cover.1456275967.git.horms+renesas@verge.net.au>
References: <cover.1456275967.git.horms+renesas@verge.net.au>
Message-ID: <cf77db5165b606fca7d1d59735528ee43202392e.1456275967.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove comment that used to be part of non-multiplatform
kernel support. Now with multiplatform-only we have no
Renesas-specific System Configuration entries.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index cd5f171f83ce..aa0b1a177d3e 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -99,6 +99,4 @@ config ARCH_SH73A0
 	bool "SH-Mobile AG5 (R8A73A00)"
 	select ARCH_RMOBILE
 	select RENESAS_INTC_IRQPIN
-
-comment "Renesas ARM SoCs System Configuration"
 endif
-- 
2.1.4
