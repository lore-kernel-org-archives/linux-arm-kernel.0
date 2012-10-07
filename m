From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun,  7 Oct 2012 14:14:41 +1300
Subject: [PATCH] dtb: Add arch-vt8500 board files to arch/arm/boot/dts/Makefile
Message-ID: <1349572481-26526-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add board files (vt8500-bv07, wm8505-ref and wm8650-mid)
to allow 'make dtbs' on arch-vt8500.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/boot/dts/Makefile |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 43c084c..ef088de 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -97,5 +97,8 @@ dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb \
 	vexpress-v2p-ca9.dtb \
 	vexpress-v2p-ca15-tc1.dtb \
 	vexpress-v2p-ca15_a7.dtb
+dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
+	wm8505-ref.dtb \
+	wm8650-mid.dtb
 
 endif
-- 
1.7.9.5
