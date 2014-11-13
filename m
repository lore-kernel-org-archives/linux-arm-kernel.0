From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Nov 2014 10:19:53 +0900
Subject: [PATCH 1/3] ARM: shmobile: r8a7790: Fix SD3CKCR address
In-Reply-To: <cover.1415757100.git.horms+renesas@verge.net.au>
References: <cover.1415757100.git.horms+renesas@verge.net.au>
Message-ID: <a926a12b5f11007d0ba9eb2e083d86054fb29a06.1415757100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 126ddaf..f622652 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -68,7 +68,7 @@
 
 #define SDCKCR		0xE6150074
 #define SD2CKCR		0xE6150078
-#define SD3CKCR		0xE615007C
+#define SD3CKCR		0xE615026C
 #define MMC0CKCR	0xE6150240
 #define MMC1CKCR	0xE6150244
 #define SSPCKCR		0xE6150248
-- 
2.1.1
