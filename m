From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  7 Jan 2011 17:11:24 +0100
Subject: [PATCH] ARM i.MX27 3ds: Fix mc13783 regulator names
In-Reply-To: <1294416684-7100-1-git-send-email-s.hauer@pengutronix.de>
References: <1294416684-7100-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1294416684-7100-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-mx27_3ds.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 6fd0f8f..83f8e2b 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -215,10 +215,10 @@ static struct regulator_init_data vgen_init = {
 
 static struct mc13783_regulator_init_data mx27_3ds_regulators[] = {
 	{
-		.id = MC13783_REGU_VMMC1,
+		.id = MC13783_REG_VMMC1,
 		.init_data = &vmmc1_init,
 	}, {
-		.id = MC13783_REGU_VGEN,
+		.id = MC13783_REG_VGEN,
 		.init_data = &vgen_init,
 	},
 };
-- 
1.7.2.3
