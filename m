From: ulfalizer@gmail.com (Ulf Magnusson)
Date: Tue, 30 Jan 2018 20:05:31 +0100
Subject: [PATCH 09/10] arm: vt8500: kconfig: Remove empty help text
In-Reply-To: <20180130190555.6577-1-ulfalizer@gmail.com>
References: <20180130190555.6577-1-ulfalizer@gmail.com>
Message-ID: <20180130190555.6577-10-ulfalizer@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for adding a warning ("kconfig: Warn if help text is
blank"): https://lkml.org/lkml/2018/1/30/516

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/arm/mach-vt8500/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index 1156a585dafc..8841199058ea 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -13,7 +13,6 @@ config ARCH_WM8505
  	depends on ARCH_MULTI_V5
  	select ARCH_VT8500
  	select CPU_ARM926T
- 	help
 
 config ARCH_WM8750
 	bool "WonderMedia WM8750"
-- 
2.14.1
