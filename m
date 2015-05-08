From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  8 May 2015 13:07:12 +0900
Subject: [PATCH v7 2/4] ARM: multi_v7_defconfig: enable UniPhier SoC family
In-Reply-To: <1431058034-5508-1-git-send-email-yamada.masahiro@socionext.com>
References: <1431058034-5508-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1431058034-5508-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add UniPhier, a new citizen in the ARM multi platform.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index dca6983..a80ed4e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -83,6 +83,7 @@ CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
+CONFIG_ARCH_UNIPHIER=y
 CONFIG_ARCH_U8500=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
-- 
1.9.1
