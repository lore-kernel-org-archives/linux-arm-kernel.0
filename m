From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 18 May 2010 16:02:58 +0900
Subject: [PATCH 7/9] ARM: SMDK6442: Add audio devices on board
In-Reply-To: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
References: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274166178-8226-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add audio platform devices on the smdk by default.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6442/mach-smdk6442.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p6442/mach-smdk6442.c b/arch/arm/mach-s5p6442/mach-smdk6442.c
index 0d63371..ebcf997 100644
--- a/arch/arm/mach-s5p6442/mach-smdk6442.c
+++ b/arch/arm/mach-s5p6442/mach-smdk6442.c
@@ -65,6 +65,7 @@ static struct s3c2410_uartcfg smdk6442_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdk6442_devices[] __initdata = {
+	&s5p6442_device_iis0,
 };
 
 static void __init smdk6442_map_io(void)
-- 
1.6.2.5
