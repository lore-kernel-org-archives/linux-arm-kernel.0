From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 28 Sep 2011 12:20:56 +0200
Subject: [PATCH 4/8] S3C2416: Add comment describing the armdiv/armclk
In-Reply-To: <201109281217.33813.heiko@sntech.de>
References: <201109281217.33813.heiko@sntech.de>
Message-ID: <201109281220.57306.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/clock.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 3060796..7aa0cfa 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -28,6 +28,14 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-s3c2443-clock.h>
 
+/* armdiv
+ *
+ * this clock is sourced from msysclk and can have a number of
+ * divider values applied to it to then be fed into armclk.
+ * The real clock definition is done in s3c2443-clock.c,
+ * only the armdiv divisor table must be defined here.
+*/
+
 static unsigned int armdiv[8] = {
 	[0] = 1,
 	[1] = 2,
-- 
1.7.5.4
