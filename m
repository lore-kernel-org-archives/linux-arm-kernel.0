From: xiechao.mail@gmail.com (Chao Xie)
Date: Wed, 21 Nov 2012 21:05:04 -0500
Subject: [PATCH 23/29] arm: mmp: add extern chip support for brownstone
In-Reply-To: <1353549910-988-1-git-send-email-xiechao.mail@gmail.com>
References: <1353549910-988-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1353549910-988-23-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
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
