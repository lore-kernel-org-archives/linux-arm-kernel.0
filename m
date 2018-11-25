From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 20:20:25 -0200
Subject: [PATCH v3 1/3] ARM: imx_v6_v7_defconfig: Remove explicit ARM_UNWIND
 disable
Message-ID: <20181125222027.22071-1-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
selected by ARM EABI (AEBI) support.  This is done in preparation to making
further changes to this defconfig cleaner.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v3:
- mention it is enabled by ARM EABI support (Arnd Bergmann)

Changes in v2:
- rework commit log (Fabio Estevam)

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
2.19.2
