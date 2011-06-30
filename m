From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 17:15:29 +0900
Subject: [PATCH v3 6/6] Exynos4 NURI: configure rtc-s3c.
In-Reply-To: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309421729-11172-7-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/mach-nuri.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 0c9401c..bdf7a5c 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -1098,6 +1098,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s3c_device_i2c3,
 	&i2c9_gpio,
 	&s3c_device_adc,
+	&s3c_device_rtc,
 
 	/* NURI Devices */
 	&nuri_gpio_keys,
-- 
1.7.4.1
