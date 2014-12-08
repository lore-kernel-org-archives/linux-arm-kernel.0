From: olof@lixom.net (Olof Johansson)
Date: Mon,  8 Dec 2014 13:54:05 -0800
Subject: [PATCH 2/2] clk: bcm: kona: make a variable static
In-Reply-To: <1418075645-14571-1-git-send-email-olof@lixom.net>
References: <1418075645-14571-1-git-send-email-olof@lixom.net>
Message-ID: <1418075645-14571-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not used outside of this file.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/clk/bcm/clk-kona-setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-kona-setup.c b/drivers/clk/bcm/clk-kona-setup.c
index e5aeded..152e7fe 100644
--- a/drivers/clk/bcm/clk-kona-setup.c
+++ b/drivers/clk/bcm/clk-kona-setup.c
@@ -21,7 +21,7 @@
 #define selector_clear_exists(sel)	((sel)->width = 0)
 #define trigger_clear_exists(trig)	FLAG_CLEAR(trig, TRIG, EXISTS)
 
-LIST_HEAD(ccu_list);	/* The list of set up CCUs */
+static LIST_HEAD(ccu_list);	/* The list of set up CCUs */
 
 /* Validity checking */
 
-- 
1.7.10.4
