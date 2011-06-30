From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 17:15:27 +0900
Subject: [PATCH v3 4/6] Exynos4 NURI: configure ADC.
In-Reply-To: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309421729-11172-5-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/mach-nuri.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 2467a2a..e81e8ca 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -29,6 +29,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
+#include <plat/adc.h>
 #include <plat/regs-serial.h>
 #include <plat/exynos4.h>
 #include <plat/cpu.h>
@@ -1020,6 +1021,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s5p_device_ehci,
 	&s3c_device_i2c3,
 	&i2c9_gpio,
+	&s3c_device_adc,
 
 	/* NURI Devices */
 	&nuri_gpio_keys,
-- 
1.7.4.1
