From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  5 Mar 2012 23:45:43 +0000
Subject: [PATCH] ARM: S3C64XX: Add some more Cragganmore module IDs to the
 table
Message-ID: <1330991143-12349-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just IDs for diagnostics, nothing is actually supported. Not all of
these have board numbers assigned yet, these will be updated as the
numbers are assigned.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

It'd be really nice to get this into 3.4 if possible, I know it's a bit
late but it's a very simple and non-invasive patch.

 arch/arm/mach-s3c64xx/mach-crag6410-module.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 317f866..e248581 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -192,10 +192,14 @@ static __devinitdata const struct {
 	{ .id = 0x02, .name = "1251-EV1 Jura" },
 	{ .id = 0x03, .name = "1252-EV1 Glenlivet" },
 	{ .id = 0x11, .name = "6249-EV2 Glenfarclas", },
+	{ .id = 0x14, .name = "6271-EV1 Lochnagar" },
+	{ .id = 0x15, .name = "XXXX-EV1 Bells" },
 	{ .id = 0x21, .name = "1275-EV1 Mortlach" },
 	{ .id = 0x25, .name = "1274-EV1 Glencadam" },
 	{ .id = 0x31, .name = "1253-EV1 Tomatin",
 	  .spi_devs = wm1253_devs, .num_spi_devs = ARRAY_SIZE(wm1253_devs) },
+	{ .id = 0x32, .name = "XXXX-EV1 Caol Illa" },
+	{ .id = 0x33, .name = "XXXX-EV1 Oban" },
 	{ .id = 0x39, .name = "1254-EV1 Dallas Dhu",
 	  .i2c_devs = wm1254_devs, .num_i2c_devs = ARRAY_SIZE(wm1254_devs) },
 	{ .id = 0x3a, .name = "1259-EV1 Tobermory",
-- 
1.7.9.1
