From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:49:36 +0200
Subject: [PATCH 0100/1529] Fix typo
Message-ID: <20160521114936.4554-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-mmp/gplugd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index c224119..4d30529 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -157,7 +157,7 @@ static int gplugd_eth_init(void)
 struct pxa168_eth_platform_data gplugd_eth_platform_data = {
 	.port_number = 0,
 	.phy_addr    = 0,
-	.speed       = 0, /* Autonagotiation */
+	.speed       = 0, /* Autonegotiation */
 	.intf        = PHY_INTERFACE_MODE_RMII,
 	.init        = gplugd_eth_init,
 };
-- 
2.8.2.534.g1f66975
