From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 14 Oct 2016 18:30:32 +0530
Subject: [PATCH 8/9] ARM: omap2plus_defconfig: Enable REGULATOR_GPIO
In-Reply-To: <20161014130033.14172-1-lokeshvutla@ti.com>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
Message-ID: <20161014130033.14172-9-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO regulator is used on dra71-evm platform to control MMCSD IO
voltage

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 53e1a88..5695cff 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -270,6 +270,7 @@ CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS65910=y
 CONFIG_TWL6040_CORE=y
+CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_LP872X=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PBIAS=y
-- 
2.9.3
