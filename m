From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 14 Oct 2016 18:30:33 +0530
Subject: [PATCH 9/9] ARM: omap2plus_defconfig: Enable LP873X support
In-Reply-To: <20161014130033.14172-1-lokeshvutla@ti.com>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
Message-ID: <20161014130033.14172-10-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LP873X family of PMICs are used in dra71x-evm, So enable the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5695cff..e3fdf4d 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -267,11 +267,13 @@ CONFIG_TWL4030_WATCHDOG=m
 CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
+CONFIG_MFD_TI_LP873X=y
 CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS65910=y
 CONFIG_TWL6040_CORE=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_LP872X=y
+CONFIG_REGULATOR_LP873X=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PBIAS=y
 CONFIG_REGULATOR_TI_ABB=y
-- 
2.9.3
