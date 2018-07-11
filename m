From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 11 Jul 2018 16:31:23 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable support for RZN1D-DB
Message-ID: <20180711143123.4838-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for the Renesas RZN1D-DB Board:
  - RZ/N1D (R9A06G032) base SoC support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 155d1eb10c6580fe..d0dea6cad4eb7613 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -89,6 +89,7 @@ CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7792=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
+CONFIG_ARCH_R9A06G032=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_PLAT_SPEAR=y
-- 
2.17.1
