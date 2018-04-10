From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Tue, 10 Apr 2018 09:30:01 +0100
Subject: [PATCH v4 1/8] arm: shmobile: Add the RZ/N1 arch to the shmobile
 Kconfig
In-Reply-To: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <1523349015-37985-2-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the RZ/N1 Family (Part #R9A06G0xx) ARCH config to the rest of
the Renesas SoC collection.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 280e731..221fbcb 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -110,6 +110,11 @@ config ARCH_R8A7794
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
2.7.4
