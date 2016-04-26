From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 26 Apr 2016 03:37:30 +0300
Subject: [PATCH 7/7] ARM: dts: lpc32xx: phy3250: add SoC name prefix to board
 dts file
In-Reply-To: <1461631050-10479-1-git-send-email-vz@mleia.com>
References: <1461631050-10479-1-git-send-email-vz@mleia.com>
Message-ID: <1461631050-10479-8-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To simplify matching of DTS files of all NXP LPC32xx powered boards by
a file name add 'lpc3250' prefix to PHYTEC PHYCORE-LPC3250 board dts
file.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/Makefile                             | 2 +-
 arch/arm/boot/dts/{phy3250.dts => lpc3250-phy3250.dts} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/boot/dts/{phy3250.dts => lpc3250-phy3250.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9f8b14f..4733ec9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -242,7 +242,7 @@ dtb-$(CONFIG_ARCH_LPC18XX) += \
 	lpc4357-ea4357-devkit.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += \
 	lpc3250-ea3250.dtb \
-	phy3250.dtb
+	lpc3250-phy3250.dtb
 dtb-$(CONFIG_MACH_MESON6) += \
 	meson6-atv1200.dtb
 dtb-$(CONFIG_MACH_MESON8) += \
diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/lpc3250-phy3250.dts
similarity index 100%
rename from arch/arm/boot/dts/phy3250.dts
rename to arch/arm/boot/dts/lpc3250-phy3250.dts
-- 
2.1.4
