From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  9 Mar 2016 11:24:16 +0100
Subject: [PATCH v2 14/18] arm: Add build support for mach-oxnas
In-Reply-To: <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1457519060-6038-15-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Kconfig and Makefile support for mach-oxnas.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/Kconfig  | 2 ++
 arch/arm/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4f799e5..2025fc9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -801,6 +801,8 @@ source "arch/arm/plat-pxa/Kconfig"
 
 source "arch/arm/mach-mmp/Kconfig"
 
+source "arch/arm/mach-oxnas/Kconfig"
+
 source "arch/arm/mach-qcom/Kconfig"
 
 source "arch/arm/mach-realview/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index fe25410..0e96c63 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -194,6 +194,7 @@ machine-$(CONFIG_ARCH_NSPIRE)		+= nspire
 machine-$(CONFIG_ARCH_OMAP1)		+= omap1
 machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
+machine-$(CONFIG_ARCH_OXNAS)		+= oxnas
 machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_QCOM)		+= qcom
-- 
1.9.1
