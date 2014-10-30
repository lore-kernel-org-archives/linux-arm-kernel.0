From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 14:57:56 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: Fix SD3CKCR address
In-Reply-To: <1414648677-31104-1-git-send-email-horms+renesas@verge.net.au>
References: <1414648677-31104-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1414648677-31104-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index c395ff1..f9bbc5f 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -64,7 +64,7 @@
 
 #define SDCKCR		0xE6150074
 #define SD2CKCR		0xE6150078
-#define SD3CKCR		0xE615007C
+#define SD3CKCR		0xE615026C
 #define MMC0CKCR	0xE6150240
 #define MMC1CKCR	0xE6150244
 #define SSPCKCR		0xE6150248
-- 
2.1.1
