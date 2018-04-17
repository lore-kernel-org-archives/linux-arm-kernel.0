From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Tue, 17 Apr 2018 12:04:16 +0100
Subject: [PATCH v5 1/6] arm: shmobile: Add the RZ/N1D (R9A06G032) to the
 shmobile Kconfig
In-Reply-To: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <1523963101-56725-2-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the RZ/N1D SoC to the reset of the Renesas SoC Collection.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/mach-shmobile/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 96672da..fcc273f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -114,6 +114,10 @@ config ARCH_R8A7794
 	bool "R-Car E2 (R8A77940)"
 	select ARCH_RCAR_GEN2
 
+config ARCH_R9A06G032
+	bool "RZ/N1D (R9A06G032)"
+	select ARCH_RZN1
+
 config ARCH_RZN1
 	bool "RZ/N1 (R9A06G0xx) Family"
 	select ARM_AMBA
-- 
2.7.4
