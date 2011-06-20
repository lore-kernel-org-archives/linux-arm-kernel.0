From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 20 Jun 2011 13:48:40 -0300
Subject: [PATCH 4/6] ARM: mach-imx/mx27_3ds: Add touchscreen support
In-Reply-To: <1308588522-16586-3-git-send-email-fabio.estevam@freescale.com>
References: <1308588522-16586-1-git-send-email-fabio.estevam@freescale.com>
	<1308588522-16586-2-git-send-email-fabio.estevam@freescale.com>
	<1308588522-16586-3-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1308588522-16586-4-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx27_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index de99c32..fb1ba43 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -288,7 +288,7 @@ static struct mc13xxx_platform_data mc13783_pdata = {
 		.num_regulators = ARRAY_SIZE(mx27_3ds_regulators),
 
 	},
-	.flags  = MC13783_USE_REGULATOR,
+	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
 };
 
 /* SPI */
-- 
1.6.0.4
