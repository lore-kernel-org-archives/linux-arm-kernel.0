From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Sep 2013 14:22:32 +0200
Subject: [PATCH] ARM: multi_v7: add HREFv60 to multi_v7 defconfig
Message-ID: <1379334152-9751-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is just a standard board for the Ux500, include it in the
v7 multiplatform defconfig.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC folks: this makes also my preferred development board
boot with multi_v7. Please apply this patch directly to fixes
if you're happy with it.
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6e572c6..a333753 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -36,6 +36,7 @@ CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_TEGRA_PCI=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
 CONFIG_ARCH_U8500=y
+CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
 CONFIG_MACH_UX500_DT=y
 CONFIG_ARCH_VEXPRESS=y
-- 
1.8.3.1
