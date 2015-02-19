From: balbi@ti.com (Felipe Balbi)
Date: Thu, 19 Feb 2015 12:03:55 -0600
Subject: [PATCH 2/2] arm: configs: omap2plus_defconfig: enable TPS62362
 regulator
In-Reply-To: <1424369035-26423-1-git-send-email-balbi@ti.com>
References: <1424369035-26423-1-git-send-email-balbi@ti.com>
Message-ID: <1424369035-26423-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This regulator is used on AM437x Industrial Development Kit.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b7386524c356..8ff1a988c0f4 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -248,6 +248,7 @@ CONFIG_TWL6040_CORE=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PBIAS=y
 CONFIG_REGULATOR_TI_ABB=y
+CONFIG_REGULATOR_TPS62360=m
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_REGULATOR_TPS65217=y
-- 
2.3.0
