From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon,  8 Feb 2016 10:16:11 +0100
Subject: [PATCH 6/6] arm: alpine: select the Alpine MSI controller driver
In-Reply-To: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1454922971-17405-7-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select the Alpine MSI controller driver when using an Alpine platform.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm/mach-alpine/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-alpine/Kconfig b/arch/arm/mach-alpine/Kconfig
index 5c2d54f59f53..b41838a58ae4 100644
--- a/arch/arm/mach-alpine/Kconfig
+++ b/arch/arm/mach-alpine/Kconfig
@@ -1,6 +1,7 @@
 config ARCH_ALPINE
 	bool "Annapurna Labs Alpine platform"
 	depends on ARCH_MULTI_V7
+	select ALPINE_MSI
 	select ARM_AMBA
 	select ARM_GIC
 	select GENERIC_IRQ_CHIP
-- 
2.7.0
