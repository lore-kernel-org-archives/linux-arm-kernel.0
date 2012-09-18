From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Tue, 18 Sep 2012 18:36:08 +0200
Subject: [PATCH] arch/arm/mach-at91/gpio.c: Remove unecessary semicolon
Message-ID: <1347986174-30287-1-git-send-email-peter.senna@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Found by http://coccinelle.lip6.fr/

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
 arch/arm/mach-at91/gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index be42cf0..ea31e96 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -658,7 +658,7 @@ static int at91_gpio_show(struct seq_file *s, void *unused)
 	seq_printf(s, "Pin\t");
 	for (bank = 0; bank < gpio_banks; bank++) {
 		seq_printf(s, "PIO%c\t\t", 'A' + bank);
-	};
+	}
 	seq_printf(s, "\n\n");
 
 	/* print pin status */
-- 
1.7.11.4
