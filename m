From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 25 May 2010 16:46:53 +0200
Subject: [PATCH 1/5] ARM: mx3: pcm037: remove unused variable
In-Reply-To: <1274798817-21805-1-git-send-email-daniel@caiaq.de>
References: <1274798817-21805-1-git-send-email-daniel@caiaq.de>
Message-ID: <1274798817-21805-2-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  CC      arch/arm/mach-mx3/mach-pcm037.o
  arch/arm/mach-mx3/mach-pcm037.c: In function 'mxc_board_init':
  arch/arm/mach-mx3/mach-pcm037.c:584: warning: unused variable 'tmp'

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm037.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index cce4106..06cf61b 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -581,7 +581,6 @@ __setup("otg_mode=", pcm037_otg_mode);
 static void __init mxc_board_init(void)
 {
 	int ret;
-	u32 tmp;
 
 	mxc_iomux_set_gpr(MUX_PGP_UH2, 1);
 
-- 
1.7.1
