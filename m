From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Tue, 23 Mar 2010 19:58:26 +0100
Subject: [PATCH 8/8] MXC: mach-mx31_3ds: enable mc13783 touchscreen interface.
In-Reply-To: <1269370655.3276.177.camel@realization>
References: <1269369741.3276.162.camel@realization>
	<1269370017.3276.165.camel@realization>
	<1269370175.3276.168.camel@realization>
	<1269370228.3276.169.camel@realization>
	<1269370305.3276.171.camel@realization>
	<1269370438.3276.173.camel@realization>
	<1269370499.3276.174.camel@realization>
	<1269370655.3276.177.camel@realization>
Message-ID: <1269370706.3276.178.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 258e8d1..a430b5b 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -392,7 +392,7 @@ static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
 static struct mc13783_platform_data mc13783_pdata __initdata = {
 	.regulators = mx31_3ds_regulators,
 	.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
-	.flags  = MC13783_USE_REGULATOR,
+	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
 };
 
 /* SPI */
-- 
1.6.3.3
