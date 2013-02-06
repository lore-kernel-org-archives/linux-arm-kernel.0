From: chao.xie@marvell.com (Chao Xie)
Date: Wed,  6 Feb 2013 02:23:50 -0500
Subject: [V6 PATCH 15/16] arm: mmp: add extern chip support for brownstone
In-Reply-To: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
References: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1360135431-27280-16-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the board support for usb as extern chip is supported
in marvell usb PHY driver

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 90c0340..3dcf38f 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -212,10 +212,8 @@ static struct mv_usb_phy_platform_data brownstone_usb_phy_pdata = {
 static struct mv_usb_platform_data brownstone_usb_pdata = {
 	.clknum		= 1,
 	.clkname	= mmp2_usb_clock_name,
-	.vbus		= NULL,
 	.mode		= MV_USB_MODE_OTG,
 	.otg_force_a_bus_req = 1,
-	.set_vbus	= NULL,
 };
 #endif
 #endif
-- 
1.7.4.1
