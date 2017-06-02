From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  2 Jun 2017 16:23:12 +0200
Subject: [PATCH v2 05/11] arm64: marvell: enable the Armada 7K/8K pinctrl
 driver
In-Reply-To: <cover.8fe5f7c62a787452878ca071fa00b953e96988ef.1496413293.git-series.gregory.clement@free-electrons.com>
References: <cover.8fe5f7c62a787452878ca071fa00b953e96988ef.1496413293.git-series.gregory.clement@free-electrons.com>
Message-ID: <c8bde2360c423649abfbb63eb418ba2b58ad3c2b.1496413293.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit makes sure the drivers for the Armada 7K/8K pin controllers
are enabled.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b4e919ac73f6..c8fc2e7f0152 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -113,6 +113,8 @@ config ARCH_MVEBU
 	select OF_GPIO
 	select PINCTRL
 	select PINCTRL_ARMADA_37XX
+	select PINCTRL_ARMADA_AP806
+	select PINCTRL_ARMADA_CP110
 	help
 	  This enables support for Marvell EBU familly, including:
 	   - Armada 3700 SoC Family
-- 
git-series 0.9.1
