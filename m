From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 18 May 2010 16:03:07 +0900
Subject: [PATCH 9/9] ARM: SMDK6440: Add audio devices on board
In-Reply-To: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
References: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <1274166187-8290-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add audio platform devices on the smdk by default.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6440/mach-smdk6440.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
index 3ae88f2..d7fede9 100644
--- a/arch/arm/mach-s5p6440/mach-smdk6440.c
+++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
@@ -84,6 +84,7 @@ static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdk6440_devices[] __initdata = {
+	&s5p6440_device_iis,
 };
 
 static void __init smdk6440_map_io(void)
-- 
1.6.2.5
