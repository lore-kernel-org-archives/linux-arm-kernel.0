From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 23 Feb 2018 15:46:46 +0100
Subject: [PATCH] arm: dts: zynq: Use SPDX-License-Identifier
Message-ID: <21416e9b76509131db1cb7adcd42f2cae8d6b2ef.1519397204.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow trend and use the SPDX License description.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi      | 12 ++----------
 arch/arm/boot/dts/zynq-microzed.dts   | 10 +---------
 arch/arm/boot/dts/zynq-parallella.dts | 10 +---------
 arch/arm/boot/dts/zynq-zc702.dts      | 10 +---------
 arch/arm/boot/dts/zynq-zc706.dts      | 10 +---------
 arch/arm/boot/dts/zynq-zed.dts        | 10 +---------
 arch/arm/boot/dts/zynq-zybo.dts       | 10 +---------
 7 files changed, 8 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 0f79fe1ccd9d..e22507e23303 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2011 - 2014 Xilinx
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * Copyright (C) 2011 - 2014 Xilinx
  */
 
 / {
diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
index b9376a4904b4..e017cb67ffba 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2011 - 2014 Xilinx
  * Copyright (C) 2016 Jagan Teki <jteki@openedev.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 /dts-v1/;
 /include/ "zynq-7000.dtsi"
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 0144acfa9793..c05f4b67d4c1 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014 SUSE LINUX Products GmbH
  *
@@ -6,15 +7,6 @@
  *  Copyright (C) 2011 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
  *  Copyright (C) 2013 Xilinx
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 /dts-v1/;
 /include/ "zynq-7000.dtsi"
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index ff3a7d22afba..f2330b0cb63d 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2011 - 2014 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 /dts-v1/;
 #include "zynq-7000.dtsi"
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 1825f5722ab9..3ad1260ff2a1 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2011 - 2014 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 /dts-v1/;
 #include "zynq-7000.dtsi"
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 5e44dc12fd60..53c6883ce1f6 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2011 - 2014 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 /dts-v1/;
 #include "zynq-7000.dtsi"
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index e40cafc5ee5b..a6c00e7fa767 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2011 - 2014 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 /dts-v1/;
 #include "zynq-7000.dtsi"
-- 
1.9.1
