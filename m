From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 12 Jun 2017 17:34:55 +0200
Subject: [PATCH v3 4/9] arm64: marvell: enable the Armada 7K/8K pinctrl driver
In-Reply-To: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
References: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
Message-ID: <30ebac2a9f20c05d354eb3f41ad21cdda8a45ae9.1497281623.git-series.gregory.clement@free-electrons.com>
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
index 73272f43ca01..bb064c42e74c 100644
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
