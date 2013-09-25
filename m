From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Sep 2013 17:56:35 +0300
Subject: [PATCH] ARM: sunxi: Order Kconfig options alphabetically
Message-ID: <1380120995-9242-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b78931d..33cef54 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -6,10 +6,10 @@ config ARCH_SUNXI
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select HAVE_SMP
 	select PINCTRL
+	select PINCTRL_SUNXI
 	select SPARSE_IRQ
 	select SUN4I_TIMER
 	select SUN5I_HSTIMER
-	select PINCTRL_SUNXI
 	select ARM_GIC
-	select HAVE_SMP
-- 
1.8.4
