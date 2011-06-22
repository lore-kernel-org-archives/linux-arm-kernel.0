From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 22 Jun 2011 09:25:26 -0300
Subject: [PATCH v2 4/6] ARM: mach-imx/mx27_3ds: Add touchscreen support
In-Reply-To: <1308745528-22089-3-git-send-email-fabio.estevam@freescale.com>
References: <1308745528-22089-1-git-send-email-fabio.estevam@freescale.com>
	<1308745528-22089-2-git-send-email-fabio.estevam@freescale.com>
	<1308745528-22089-3-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1308745528-22089-4-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Rebased on Sascha's for-next branch

 arch/arm/mach-imx/mach-mx27_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 838421c..aefe751 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -292,7 +292,7 @@ static struct mc13xxx_platform_data mc13783_pdata = {
 		.num_regulators = ARRAY_SIZE(mx27_3ds_regulators),
 
 	},
-	.flags  = MC13783_USE_REGULATOR,
+	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
 };
 
 /* SPI */
-- 
1.6.0.4
