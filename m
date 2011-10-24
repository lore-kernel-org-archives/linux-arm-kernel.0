From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 24 Oct 2011 16:09:36 +0200
Subject: [PATCH V3 (bugfix to fold)] ARM: at91: usb_a9g20.dts: fix memory
	location
In-Reply-To: <d139db89b4e9830e813abf1329ce1ac499653f2c.1319464310.git.nicolas.ferre@atmel.com>
References: <d139db89b4e9830e813abf1329ce1ac499653f2c.1319464310.git.nicolas.ferre@atmel.com>
Message-ID: <1319465376-8613-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/usb_a9g20.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index a060f6c..d66e2c0 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -16,7 +16,7 @@
 		bootargs = "mem=64M console=ttyS0,115200 mtdparts=atmel_nand:128k(at91bootstrap),256k(barebox)ro,128k(bareboxenv),128k(bareboxenv2),4M(kernel),120M(rootfs),-(data) root=/dev/mtdblock5 rw rootfstype=ubifs";
 	};
 
-	memory at 70000000 {
+	memory at 20000000 {
 		reg = <0x20000000 0x4000000>;
 	};
 
-- 
1.7.5.4
