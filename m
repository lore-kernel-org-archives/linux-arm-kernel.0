From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:11:56 -0700
Subject: [PATCH 22/28] omap: Devkit8000: Fix typo in supplies
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231156.31953.21428.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Weber <weber@corscience.de>

Replace wrong vdss_dsi with vdds_dsi.

Signed-off-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index db4c093..b82e438 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -303,7 +303,7 @@ static struct regulator_consumer_supply devkit8000_vpll2_supplies[] = {
 	.dev		= &devkit8000_lcd_device.dev,
 	},
 	{
-	.supply		= "vdss_dsi",
+	.supply		= "vdds_dsi",
 	.dev		= &devkit8000_dss_device.dev,
 	}
 };
