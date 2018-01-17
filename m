From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 17 Jan 2018 15:37:36 +0100
Subject: [PATCH] arm: zynq: Add SPDX GPL-2.0 license identifier
Message-ID: <bd5bfbcc2f280977acfdb091f4c8c174ef5a9ee0.1516199853.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPDX identifier as was done by for example by:
"License cleanup: add SPDX GPL-2.0 license identifier to files with no
license" (commit <b24413180f5600bcb3bb70fbed5cf186b60864bd>)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi      | 1 +
 arch/arm/boot/dts/zynq-microzed.dts   | 1 +
 arch/arm/boot/dts/zynq-parallella.dts | 1 +
 arch/arm/boot/dts/zynq-zc702.dts      | 1 +
 arch/arm/boot/dts/zynq-zc706.dts      | 1 +
 arch/arm/boot/dts/zynq-zed.dts        | 1 +
 arch/arm/boot/dts/zynq-zybo.dts       | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 0f79fe1ccd9d..f29c7ca4a38a 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2011 - 2014 Xilinx
  *
diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
index 5c1541c9a49b..dc43ba34e830 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2011 - 2014 Xilinx
  * Copyright (C) 2016 Jagan Teki <jteki@openedev.com>
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 0144acfa9793..beaaecfa0709 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014 SUSE LINUX Products GmbH
  *
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 3d97c1133a95..46f14422b2e7 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2011 - 2014 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index c8b22e1a64bf..9224b45f9418 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2011 - 2014 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 702cd77036f5..c8fad19e07dd 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2011 - 2014 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index 1812df471936..b0ad94cb9e4a 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2011 - 2014 Xilinx
  *  Copyright (C) 2012 National Instruments Corp.
-- 
1.9.1
