From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 22:30:38 +0200
Subject: [PATCH 10/13] arm64: Kconfig: sunxi: add PINCTRL
In-Reply-To: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
Message-ID: <20160726203041.29366-11-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Add required PINCTRL symbol to cover non-defconfig setups.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4cc444c3c2e9..83bc4bf3513b 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -3,6 +3,7 @@ menu "Platform selection"
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select GENERIC_IRQ_CHIP
+	select PINCTRL
 	select PINCTRL_SUN50I_A64
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
-- 
2.9.2
