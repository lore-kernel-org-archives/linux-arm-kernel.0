From: eric.miao@linaro.org (Eric Miao)
Date: Wed,  7 Dec 2011 22:44:11 +0800
Subject: [PATCH] ARM: imx6q: generate imx6q dtb files
Message-ID: <1323269051-29007-1-git-send-email-eric.miao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Eric Miao <eric.miao@linaro.org>
---
 arch/arm/mach-imx/Makefile.boot |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index cfede57..67b76f5 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -25,3 +25,6 @@ initrd_phys-$(CONFIG_SOC_IMX35)	:= 0x80800000
 zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
 params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
 initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
+
+dtb-$(CONFIG_SOC_IMX6Q)	+= imx6q-sabreauto.dtb \
+			   imx6q-sabrelite.dtb
-- 
1.7.5.4
