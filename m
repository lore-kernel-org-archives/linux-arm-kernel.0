From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 21 May 2010 05:04:25 +0200
Subject: [PATCH] pcm037: fix build warning
Message-ID: <1274411065-10855-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-mx3/mach-pcm037.c:584: warning: unused variable 'tmp'

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm037.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 5024284..d19ba54 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -581,7 +581,6 @@ __setup("otg_mode=", pcm037_otg_mode);
 static void __init mxc_board_init(void)
 {
 	int ret;
-	u32 tmp;
 
 	mxc_iomux_set_gpr(MUX_PGP_UH2, 1);
 
-- 
1.7.0
