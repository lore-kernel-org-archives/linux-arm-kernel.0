From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 08 Oct 2013 12:39:20 +0900
Subject: [PATCH 03/08] ARM: shmobile: Select GPIO in case of the r8a7791 SoC
In-Reply-To: <20131008033851.20455.68845.sendpatchset@w520>
References: <20131008033851.20455.68845.sendpatchset@w520>
Message-ID: <20131008033920.20455.61245.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Make it possible to build GPIO on r8a7791.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- 0010/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-10-07 13:35:19.000000000 +0900
@@ -97,6 +97,7 @@ config ARCH_R8A7790
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
