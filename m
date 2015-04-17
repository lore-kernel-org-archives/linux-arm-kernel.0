From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 18 Apr 2015 00:48:16 +0900
Subject: [PATCH v3 2/4] ARM: multi_v7_defconfig: enable UniPhier SoC family
In-Reply-To: <1429285698-11829-1-git-send-email-yamada.masahiro@socionext.com>
References: <1429285698-11829-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1429285698-11829-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add UniPhier, a new citizen in the ARM multi platform.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 06075b6..85d8a00 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -81,6 +81,7 @@ CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
+CONFIG_ARCH_UNIPHIER=y
 CONFIG_ARCH_U8500=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
-- 
1.9.1
