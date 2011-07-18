From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Mon, 18 Jul 2011 12:22:11 +0530
Subject: [PATCH 3/3] ARM: pxa168: Add USB support for gplugD board
In-Reply-To: <1310971931-4825-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <1310971931-4825-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <1310971931-4825-4-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 arch/arm/mach-mmp/gplugd.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 98e25d9..5a27355 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -186,6 +186,7 @@ static void __init gplugd_init(void)
 	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(gplugd_i2c_board_info));
 
 	pxa168_add_eth(&gplugd_eth_platform_data);
+	pxa168_add_usb_host(NULL);
 }
 
 MACHINE_START(SHEEVAD, "PXA168-based GuruPlug Display (gplugD) Platform")
-- 
1.7.0.4
