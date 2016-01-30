From: djkurtz@chromium.org (Daniel Kurtz)
Date: Sat, 30 Jan 2016 10:38:24 +0800
Subject: [PATCH] ARM: dts: cros-ec-keyboard: Add LOCK key to keyboard matrix
Message-ID: <1454121504-12683-1-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Chao <james_chao@asus.com>

The LOCK key is at KSO9/KSI3 for Chromebook Flip and other devices
that use the Chrome OS EC keyboard matrix.

Signed-off-by: James Chao <james_chao@asus.com>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: YH Huang <yh.huang@mediatek.com>
---
 arch/arm/boot/dts/cros-ec-keyboard.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/cros-ec-keyboard.dtsi b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
index 4e42f30c..c045105 100644
--- a/arch/arm/boot/dts/cros-ec-keyboard.dtsi
+++ b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
@@ -55,6 +55,7 @@
 			MATRIX_KEY(0x03, 0x04, KEY_F5)
 			MATRIX_KEY(0x03, 0x06, KEY_6)
 			MATRIX_KEY(0x03, 0x08, KEY_MINUS)
+			MATRIX_KEY(0x03, 0x09, KEY_F13)
 			MATRIX_KEY(0x03, 0x0b, KEY_BACKSLASH)
 			MATRIX_KEY(0x03, 0x0c, KEY_MUHENKAN)
 
-- 
2.7.0.rc3.207.g0ac5344
