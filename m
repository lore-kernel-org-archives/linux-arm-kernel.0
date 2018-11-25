From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 18:17:27 -0200
Subject: [PATCH 1/3] ARM: imx_v6_v7_defconfig: Remove CONFIG_ARM_UNWIND
Message-ID: <20181125201729.19836-1-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The setting is removed when running a `savedefconfig` using the
current setting set. It is being applied in preparation to some
patches making changes to this defconfig.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/configs/imx_v6_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index aa02d18f44d1..0c887a059df3 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -445,4 +445,3 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_PROVE_LOCKING=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FTRACE is not set
-# CONFIG_ARM_UNWIND is not set
-- 
2.19.1
