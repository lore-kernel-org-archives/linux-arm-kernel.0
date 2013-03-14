From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 14 Mar 2013 13:27:42 +0200
Subject: [PATCH 3/4] arm: mach-pxa: amend Kconfig after mtdchar merge
In-Reply-To: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
References: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
Message-ID: <1363260463-10609-3-git-send-email-dedekind1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

The mtdchar module was merged with the mtdcore module, which means that the
MTD_CHAR Kconfig symbol does not exist any more.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/arm/mach-pxa/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 86eec41..0e74ba0 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -160,7 +160,6 @@ config MACH_XCEP
 	select MTD
 	select MTD_CFI
 	select MTD_CFI_INTELEXT
-	select MTD_CHAR
 	select MTD_PHYSMAP
 	select PXA25x
 	select SMC91X
-- 
1.7.10.4
