From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 18 May 2010 16:02:30 +0900
Subject: [PATCH 2/9] ARM: SMDKV210: Add audio devices on board
In-Reply-To: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
References: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274166150-6494-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add audio platform devices on the smdk by default.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pv210/mach-smdkv210.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index a278832..3c29e18 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -72,6 +72,8 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdkv210_devices[] __initdata = {
+	&s5pv210_device_iis0,
+	&s5pv210_device_ac97,
 };
 
 static void __init smdkv210_map_io(void)
-- 
1.6.2.5
