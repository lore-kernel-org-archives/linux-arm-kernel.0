From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 16 Jul 2014 01:01:22 +0200
Subject: [PATCH 3/6] ARM: Kconfig: set default gpio number for rockchip SoCs
In-Reply-To: <1471578.ILeMmG2DL6@diego>
References: <1471578.ILeMmG2DL6@diego>
Message-ID: <2242498.pAI32mTkmn@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new rk3288 needs a bigger gpio space, as it has 9 gpio banks.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87b63fd..8d1dee0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1574,6 +1574,7 @@ config ARCH_NR_GPIO
 	default 416 if ARCH_SUNXI
 	default 392 if ARCH_U8500
 	default 352 if ARCH_VT8500
+	default 288 if ARCH_ROCKCHIP
 	default 264 if MACH_H4700
 	default 0
 	help
-- 
1.9.0
