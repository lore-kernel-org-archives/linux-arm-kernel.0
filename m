From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 30 Jun 2012 14:08:58 +0200
Subject: [PATCH 06/10] ARM: S3C24XX: Remove unused GPA, GPE,
 GPH bank GPIO aliases
In-Reply-To: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <1341058142-30438-7-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is now no more users of these compatibility definitions,
so remove them.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h b/arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h
index 019ea86..3890a05 100644
--- a/arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h
+++ b/arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h
@@ -93,26 +93,5 @@ enum s3c_gpio_number {
 #define S3C2410_GPL(_nr)	(S3C2410_GPIO_L_START + (_nr))
 #define S3C2410_GPM(_nr)	(S3C2410_GPIO_M_START + (_nr))
 
-/* compatibility until drivers can be modified */
-
-#define S3C2410_GPA0	S3C2410_GPA(0)
-#define S3C2410_GPA1	S3C2410_GPA(1)
-#define S3C2410_GPA3	S3C2410_GPA(3)
-#define S3C2410_GPA7	S3C2410_GPA(7)
-
-#define S3C2410_GPE0	S3C2410_GPE(0)
-#define S3C2410_GPE1	S3C2410_GPE(1)
-#define S3C2410_GPE2	S3C2410_GPE(2)
-#define S3C2410_GPE3	S3C2410_GPE(3)
-#define S3C2410_GPE4	S3C2410_GPE(4)
-#define S3C2410_GPE5	S3C2410_GPE(5)
-#define S3C2410_GPE6	S3C2410_GPE(6)
-#define S3C2410_GPE7	S3C2410_GPE(7)
-#define S3C2410_GPE8	S3C2410_GPE(8)
-#define S3C2410_GPE9	S3C2410_GPE(9)
-#define S3C2410_GPE10	S3C2410_GPE(10)
-
-#define S3C2410_GPH10	S3C2410_GPH(10)
-
 #endif /* __MACH_GPIONRS_H */
 
-- 
1.7.4.1
