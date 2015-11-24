From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Nov 2015 18:08:28 +0900
Subject: [PATCH 1/2] arm64: add Kconfig entry for Socionext UniPhier SoC family
In-Reply-To: <1448356109-22380-1-git-send-email-yamada.masahiro@socionext.com>
References: <1448356109-22380-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1448356109-22380-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ARM64 Linux support for Socionext UniPhier SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4043c35..0b9c8dd 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -108,6 +108,12 @@ config ARCH_THUNDER
 	help
 	  This enables support for Cavium's Thunder Family of SoCs.
 
+config ARCH_UNIPHIER
+	bool "Socionext UniPhier SoC Family"
+	select PINCTRL
+	help
+	  This enables support for Socionext UniPhier SoC family.
+
 config ARCH_VEXPRESS
 	bool "ARMv8 software model (Versatile Express)"
 	select ARCH_REQUIRE_GPIOLIB
-- 
1.9.1
