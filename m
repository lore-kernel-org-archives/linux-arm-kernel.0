From: robherring2@gmail.com (Rob Herring)
Date: Fri, 31 Jan 2014 16:06:30 -0600
Subject: [PATCH] ARM: hisi: don't select SMP
Message-ID: <1391205990-22506-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

SMP is a user configurable option, not a hardware feature and should not
be selected.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-hisi/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 018ad67..8f4649b 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -12,6 +12,5 @@ config ARCH_HI3xxx
 	select HAVE_SMP
 	select PINCTRL
 	select PINCTRL_SINGLE
-	select SMP
 	help
 	  Support for Hisilicon Hi36xx/Hi37xx processor family
-- 
1.8.3.2
