From: nm@ti.com (Nishanth Menon)
Date: Fri, 15 Dec 2017 07:20:55 -0600
Subject: [PATCH 1/8] ARM: dts: keystone*: Standardize license with SPDX tag
In-Reply-To: <20171215132102.435-1-nm@ti.com>
References: <20171215132102.435-1-nm@ti.com>
Message-ID: <20171215132102.435-2-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Standardize the licenses with SPDX license tag and standardize
TI's copyright statement to be consistent.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/keystone-clocks.dtsi      |  7 ++-----
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi  |  7 ++-----
 arch/arm/boot/dts/keystone-k2e-evm.dts      |  7 ++-----
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi   |  7 ++-----
 arch/arm/boot/dts/keystone-k2e.dtsi         |  7 ++-----
 arch/arm/boot/dts/keystone-k2g-evm.dts      | 12 ++----------
 arch/arm/boot/dts/keystone-k2g-ice.dts      |  3 +--
 arch/arm/boot/dts/keystone-k2g.dtsi         | 12 ++----------
 arch/arm/boot/dts/keystone-k2hk-clocks.dtsi |  7 ++-----
 arch/arm/boot/dts/keystone-k2hk-evm.dts     |  7 ++-----
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi  |  7 ++-----
 arch/arm/boot/dts/keystone-k2hk.dtsi        |  7 ++-----
 arch/arm/boot/dts/keystone-k2l-clocks.dtsi  |  7 ++-----
 arch/arm/boot/dts/keystone-k2l-evm.dts      |  7 ++-----
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi   |  7 ++-----
 arch/arm/boot/dts/keystone-k2l.dtsi         |  7 ++-----
 arch/arm/boot/dts/keystone.dtsi             |  7 ++-----
 17 files changed, 33 insertions(+), 92 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
index 0c334b25781e..2391e3e4d234 100644
--- a/arch/arm/boot/dts/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for Keystone 2 clock tree
  *
- * Copyright (C) 2013 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ *  Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2e-clocks.dtsi b/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
index d56d68fe7ffc..a0fe6eccca8d 100644
--- a/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2014 Texas Instruments, Inc.
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * Keystone 2 Edison SoC specific device tree
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
index f1f32c54e72f..a7b9138cceb7 100644
--- a/arch/arm/boot/dts/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * Keystone 2 Edison EVM device tree
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
index ba828cb59587..a17311c602aa 100644
--- a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for Keystone 2 Edison Netcp driver
  *
- * Copyright 2015 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 qmss: qmss at 2a40000 {
diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 6b796b52ff4f..34860c10fa4d 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * Keystone 2 Edison soc device tree
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/reset/ti-syscon.h>
diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 656af194a518..0a9af7319c93 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for K2G EVM
  *
- * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/keystone-k2g-ice.dts b/arch/arm/boot/dts/keystone-k2g-ice.dts
index 78692745e0af..6491b9860877 100644
--- a/arch/arm/boot/dts/keystone-k2g-ice.dts
+++ b/arch/arm/boot/dts/keystone-k2g-ice.dts
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for K2G Industrial Communication Engine EVM
  *
  * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
- *
- * SPDX-License-Identifier: GPL-2.0
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 8f313ff406b9..0f3126e3ba77 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for K2G SOC
  *
- * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi b/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
index af9b7190533a..142c8491ff54 100644
--- a/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * Keystone 2 Kepler/Hawking SoC clock nodes
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
index 6dd13b98aaba..2964aa67d264 100644
--- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * Keystone 2 Kepler/Hawking EVM device tree
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi b/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
index a5ac845464bf..b88c0689c285 100644
--- a/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for Keystone 2 Hawking Netcp driver
  *
- * Copyright 2015 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 qmss: qmss at 2a40000 {
diff --git a/arch/arm/boot/dts/keystone-k2hk.dtsi b/arch/arm/boot/dts/keystone-k2hk.dtsi
index 7c486d9dc90e..8f6cc98c0ef6 100644
--- a/arch/arm/boot/dts/keystone-k2hk.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * Keystone 2 Kepler/Hawking soc specific device tree
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/reset/ti-syscon.h>
diff --git a/arch/arm/boot/dts/keystone-k2l-clocks.dtsi b/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
index ef8464bb11ff..fc986909d70e 100644
--- a/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * Keystone 2 lamarr SoC clock nodes
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
index 528667618db4..bc60f1bd2a39 100644
--- a/arch/arm/boot/dts/keystone-k2l-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2014 Texas Instruments, Inc.
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * Keystone 2 Lamarr EVM device tree
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
index 66f615a74118..9ec84228bc16 100644
--- a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree Source for Keystone 2 Lamarr Netcp driver
  *
- * Copyright 2015 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 qmss: qmss at 2a40000 {
diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index 4370e6513aa4..20d2626fb054 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2014 Texas Instruments, Inc.
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * Keystone 2 Lamarr SoC specific device tree
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/reset/ti-syscon.h>
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 06e10544f9b1..ca2cc5d8e3b5 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.14.1
