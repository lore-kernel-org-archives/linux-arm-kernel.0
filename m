From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 21 Aug 2013 16:31:02 +0800
Subject: [PATCH] ARM: OMAP2: remove useless variable 'ret'
In-Reply-To: <521479B4.8030604@asianux.com>
References: <521479B4.8030604@asianux.com>
Message-ID: <52147AC6.9040300@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove useless variable 'ret', the related warning:

  arch/arm/mach-omap2/board-am3517crane.c:113:6: warning: unused variable ?ret? [-Wunused-variable]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index fc53911..0d499a1 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -110,8 +110,6 @@ static void __init am3517_crane_i2c_init(void)
 
 static void __init am3517_crane_init(void)
 {
-	int ret;
-
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-- 
1.7.7.6
