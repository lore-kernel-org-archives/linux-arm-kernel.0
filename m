From: nm@ti.com (Nishanth Menon)
Date: Thu, 9 Apr 2015 16:15:21 -0500
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: Enable generic SoC internal OMAP
 regulators
In-Reply-To: <1428614121-3374-1-git-send-email-nm@ti.com>
References: <1428614121-3374-1-git-send-email-nm@ti.com>
Message-ID: <1428614121-3374-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ABB and PBIAS are internal LDO control regulators that are needed for
maintaining proper functionality of OMAP architecture SoCs. Enable the
same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/configs/multi_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f48dfa7787dc..b86ff6e957a0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -363,8 +363,10 @@ CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX77686=y
 CONFIG_REGULATOR_PALMAS=y
+CONFIG_REGULATOR_PBIAS=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
+CONFIG_REGULATOR_TI_ABB=y
 CONFIG_REGULATOR_TPS51632=y
 CONFIG_REGULATOR_TPS62360=y
 CONFIG_REGULATOR_TPS65090=y
-- 
1.7.9.5
