From: michal.simek@xilinx.com (Michal Simek)
Date: Wed,  1 Nov 2017 13:23:34 +0100
Subject: [PATCH] arm64: dts: zynqmp: Use SPDX-License-Identifier
Message-ID: <d432b970c977750b5c32595ef2c13f16fe92ff16.1509539009.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow trend and use the SPDX License description.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi | 5 +----
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts      | 5 +----
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi           | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
index b87b8316f4ac..c85454fc9d7b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
@@ -5,10 +5,7 @@
  *
  * Michal Simek <michal.simek@xilinx.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
+ * SPDX-License-Identifier: GPL-2.0+
  */
 
 / {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index bf552674a834..49bc65e236ba 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -5,10 +5,7 @@
  *
  * Michal Simek <michal.simek@xilinx.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
+ * SPDX-License-Identifier: GPL-2.0+
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 7665fbddff28..f99fc7c477d5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -5,10 +5,7 @@
  *
  * Michal Simek <michal.simek@xilinx.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
+ * SPDX-License-Identifier: GPL-2.0+
  */
 
 / {
-- 
1.9.1
