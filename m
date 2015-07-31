From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 30 Jul 2015 18:13:57 -0700
Subject: [RFCv3 4/4] ARM: zynq: Select ARCH_HAS_RESET_CONTROLLER
In-Reply-To: <1438305237-18497-1-git-send-email-moritz.fischer@ettus.com>
References: <1438305237-18497-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1438305237-18497-5-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 arch/arm/mach-zynq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 78e5e00..77d7df7 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_ZYNQ
 	bool "Xilinx Zynq ARM Cortex A9 Platform" if ARCH_MULTI_V7
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
-- 
2.4.3
