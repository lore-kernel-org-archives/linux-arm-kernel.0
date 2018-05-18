From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:18:03 +0200
Subject: [PATCH 05/14] ARM: shmobile: Add the RZ/N1 arch to the shmobile
 Kconfig
In-Reply-To: <cover.1526639075.git.horms+renesas@verge.net.au>
References: <cover.1526639075.git.horms+renesas@verge.net.au>
Message-ID: <465bb120a87793037886024aace63365ff13108b.1526639075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michel Pollet <michel.pollet@bp.renesas.com>

Add the RZ/N1 Family (Part #R9A06G0xx) ARCH config to the rest of
the Renesas SoC collection.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6b9111455a30..96672da02f5f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -114,6 +114,11 @@ config ARCH_R8A7794
 	bool "R-Car E2 (R8A77940)"
 	select ARCH_RCAR_GEN2
 
+config ARCH_RZN1
+	bool "RZ/N1 (R9A06G0xx) Family"
+	select ARM_AMBA
+	select CPU_V7
+
 config ARCH_SH73A0
 	bool "SH-Mobile AG5 (R8A73A00)"
 	select ARCH_RMOBILE
-- 
2.11.0
