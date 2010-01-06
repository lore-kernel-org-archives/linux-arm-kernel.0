From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Wed, 06 Jan 2010 04:41:47 -0500
Subject: [PATCH 1/2] Remove unneeded __init from s3c24xx_ts_set_platdata
Message-ID: <20100106094146.17269.6955.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded __init in function definition.

Signed-off-by: Nelson Castillo <arhuaco@freaks-unidos.net>
---

 arch/arm/plat-s3c24xx/devs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 7f686a3..267f36a 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -193,7 +193,7 @@ EXPORT_SYMBOL(s3c_device_ts);
 
 static struct s3c2410_ts_mach_info s3c2410ts_info;
 
-void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_info)
+void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_info)
 {
 	memcpy(&s3c2410ts_info, hard_s3c2410ts_info, sizeof(struct s3c2410_ts_mach_info));
 	s3c_device_ts.dev.platform_data = &s3c2410ts_info;
