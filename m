From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 13 May 2013 01:51:41 -0400
Subject: [PATCh V10 10/12] arm: mmp: remove unused usb devices
In-Reply-To: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
References: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1368424303-10629-11-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We defined new usb devices for usb ehci/udc/otg/phy.
So remove the old definitions.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/include/mach/pxa910.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index c695982..d17ffee 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -19,9 +19,6 @@ extern struct pxa_device_desc pxa910_device_pwm2;
 extern struct pxa_device_desc pxa910_device_pwm3;
 extern struct pxa_device_desc pxa910_device_pwm4;
 extern struct pxa_device_desc pxa910_device_nand;
-extern struct platform_device pxa168_device_u2o;
-extern struct platform_device pxa168_device_u2ootg;
-extern struct platform_device pxa168_device_u2oehci;
 extern struct pxa_device_desc pxa910_device_u2o;
 extern struct pxa_device_desc pxa910_device_u2ootg;
 extern struct pxa_device_desc pxa910_device_u2oehci;
-- 
1.7.4.1
