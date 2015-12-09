From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed,  9 Dec 2015 17:04:13 +0800
Subject: [PATCH v1 8/8] ARM: dts: rockchip: add rk3228-evb board
In-Reply-To: <1449651853-1667-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1449651853-1667-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1449651853-1667-9-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial release for rk3228 sdk board.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 arch/arm/boot/dts/Makefile       |  1 +
 arch/arm/boot/dts/rk3228-evb.dts | 56 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3228-evb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2d8b9e0..0223846 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -521,6 +521,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3066a-marsboard.dtb \
 	rk3066a-rayeager.dtb \
 	rk3188-radxarock.dtb \
+	rk3228-evb.dtb \
 	rk3288-evb-act8846.dtb \
 	rk3288-evb-rk808.dtb \
 	rk3288-firefly-beta.dtb \
diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rk3228-evb.dts
new file mode 100644
index 0000000..eb4621a
--- /dev/null
+++ b/arch/arm/boot/dts/rk3228-evb.dts
@@ -0,0 +1,56 @@
+/*
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *  Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "rk3228.dtsi"
+
+/ {
+	model = "Rockchip RK3228 Evaluation board";
+	compatible = "rockchip,rk3228-evb", "rockchip,rk3228";
+};
+
+&emmc {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
2.1.4
