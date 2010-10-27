From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 27 Oct 2010 10:31:06 -0700 (PDT)
Subject: [PATCH 2/2] mx31_3ds: Add touchscreen support
Message-ID: <940696.67228.qm@web51006.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the mx31_3ds board the touchscreen feature is provided by MC13783 PMIC.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

---
 arch/arm/mach-mx3/mach-mx31_3ds.c |? ? 2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 71fe05b..cf399d5 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -255,7 +255,7 @@ static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
 static struct mc13783_platform_data mc13783_pdata __initdata = {
 ??? .regulators = mx31_3ds_regulators,
 ??? .num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
-??? .flags? = MC13783_USE_REGULATOR,
+??? .flags? = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
 };
 
 /* SPI */
-- 
1.6.0.4



      
