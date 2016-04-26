From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 27 Apr 2016 00:10:31 +0300
Subject: [PATCH v2 4/7] ARM: dts: lpc32xx: ea3250: add SoC name prefix to
 board dts file
In-Reply-To: <1461705034-355-1-git-send-email-vz@mleia.com>
References: <1461705034-355-1-git-send-email-vz@mleia.com>
Message-ID: <1461705034-355-5-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To simplify matching of DTS files of all NXP LPC32xx powered boards by
a file name add 'lpc3250' prefix to Embedded Artists LPC3250 board dts
file.

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
* added Sylvain's acked-by.
* rebased on top of v2 2/7 changes

 arch/arm/boot/dts/Makefile                           | 3 ++-
 arch/arm/boot/dts/{ea3250.dts => lpc3250-ea3250.dts} | 0
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename arch/arm/boot/dts/{ea3250.dts => lpc3250-ea3250.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 95c1923..9f8b14f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -241,7 +241,8 @@ dtb-$(CONFIG_ARCH_LPC18XX) += \
 	lpc4350-hitex-eval.dtb \
 	lpc4357-ea4357-devkit.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += \
-	ea3250.dtb phy3250.dtb
+	lpc3250-ea3250.dtb \
+	phy3250.dtb
 dtb-$(CONFIG_MACH_MESON6) += \
 	meson6-atv1200.dtb
 dtb-$(CONFIG_MACH_MESON8) += \
diff --git a/arch/arm/boot/dts/ea3250.dts b/arch/arm/boot/dts/lpc3250-ea3250.dts
similarity index 100%
rename from arch/arm/boot/dts/ea3250.dts
rename to arch/arm/boot/dts/lpc3250-ea3250.dts
-- 
2.1.4
