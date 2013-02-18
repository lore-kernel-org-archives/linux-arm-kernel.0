From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 18 Feb 2013 01:10:38 -0500
Subject: [V7 PATCH 16/16] arm: mmp: add extern chip support for ttc_dkb
In-Reply-To: <1361167838-22929-1-git-send-email-chao.xie@marvell.com>
References: <1361167838-22929-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1361167838-22929-17-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the board support for usb as extern chip is supported
in marvell usb PHY driver.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 5622092..0ba89e9 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -174,10 +174,8 @@ static struct mv_usb_phy_platform_data ttc_usb_phy_pdata = {
 static struct mv_usb_platform_data ttc_usb_pdata = {
 	.clknum		= 1,
 	.clkname	= pxa910_usb_clock_name,
-	.vbus		= NULL,
 	.mode		= MV_USB_MODE_OTG,
 	.otg_force_a_bus_req = 1,
-	.set_vbus	= NULL,
 };
 #endif
 #endif
-- 
1.7.4.1
