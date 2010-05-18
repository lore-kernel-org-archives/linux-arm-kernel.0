From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 18 May 2010 16:02:44 +0900
Subject: [PATCH 5/9] ARM: SMDKC100: Add audio devices on board
In-Reply-To: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
References: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274166164-6993-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add audio platform devices on the smdk by default.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pc100/mach-smdkc100.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index ae3c52c..abd46de 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -151,6 +151,8 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
 	&smdkc100_lcd_powerdev,
+	&s5pc100_device_iis0,
+	&s5pc100_device_ac97,
 };
 
 static void __init smdkc100_map_io(void)
-- 
1.6.2.5
