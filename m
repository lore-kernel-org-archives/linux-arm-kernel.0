From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 3 Nov 2010 11:33:42 -0700 (PDT)
Subject: [PATCH] mx51_3ds: Add esdhc support
Message-ID: <264491.32251.qm@web51003.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for esdhc on mx51_3ds board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

---
 arch/arm/mach-mx5/board-mx51_3ds.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index ba5805f..d731104 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -172,6 +172,7 @@ static void __init mxc_board_init(void)
 		printk(KERN_WARNING "Init of the debugboard failed, all "
 				    "devices on the board are unusable.\n");
 
+	imx51_add_esdhc(0, NULL);
 	mxc_init_keypad();
 }
 
-- 
1.6.0.4



      
