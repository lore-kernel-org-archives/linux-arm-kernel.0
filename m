From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 2 Oct 2017 20:04:40 +0200
Subject: [PATCH 6/6] ARM: s3c2412: Fix a typo in a comment line
In-Reply-To: <d2ae00c8-da57-9ffc-3692-67ed6daa95e0@users.sourceforge.net>
References: <d2ae00c8-da57-9ffc-3692-67ed6daa95e0@users.sourceforge.net>
Message-ID: <e2567b9e-d556-bac2-a810-ca478f4398bd@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Oct 2017 19:41:10 +0200

Adjust a word in this function description.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
index 01bcd7d5dac7..c5b12f6b02b5 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
@@ -35,7 +35,7 @@
 #define print_ns(x) ((x) / 10), ((x) % 10)
 
 /**
- * s3c2412_print_timing - print timing infromation via printk.
+ * s3c2412_print_timing - print timing information via printk.
  * @pfx: The prefix to print each line with.
  * @iot: The IO timing information
  */
-- 
2.14.2
