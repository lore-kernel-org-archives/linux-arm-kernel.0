From: nm@ti.com (Nishanth Menon)
Date: Sat, 16 Dec 2017 14:40:33 -0600
Subject: [PATCH V2 1/8] ARM: dts: keystone*: Standardize license with SPDX tag
In-Reply-To: <20171216204040.18017-1-nm@ti.com>
References: <20171215132102.435-1-nm@ti.com> <20171216204040.18017-1-nm@ti.com>
Message-ID: <20171216204040.18017-2-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Standardize the licenses with SPDX license tag and standardize TI's
copyright statement to be consistently after file description.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
 * Moved copyrights just after description in a few files to standardize them.

v1: https://patchwork.kernel.org/patch/10115109/

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
index 0c334b25781e..f23147093fd8 100644
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
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2e-clocks.dtsi b/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
index d56d68fe7ffc..915a99d5bc5e 100644
--- a/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2014 Texas Instruments, Inc.
- *
  * Keystone 2 Edison SoC specific device tree
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
index 2c59f4cb3b44..5378b858fb6f 100644
--- a/arch/arm/boot/dts/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
- *
  * Keystone 2 Edison EVM device tree
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
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
index 6b796b52ff4f..db4560b929f1 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
- *
  * Keystone 2 Edison soc device tree
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 #include <dt-bindings/reset/ti-syscon.h>
diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 9737730ddc21..6a4657799b99 100644
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
index 1736eb53ad83..d820ed2474bb 100644
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
index 3c48a9f5c882..8b04652b703f 100644
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
index af9b7190533a..560475346fda 100644
--- a/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
- *
  * Keystone 2 Kepler/Hawking SoC clock nodes
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
index 13759db99d81..8ea5a584e828 100644
--- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
- *
  * Keystone 2 Kepler/Hawking EVM device tree
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
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
index 7c486d9dc90e..71c1dcf4159f 100644
--- a/arch/arm/boot/dts/keystone-k2hk.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
- *
  * Keystone 2 Kepler/Hawking soc specific device tree
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 #include <dt-bindings/reset/ti-syscon.h>
diff --git a/arch/arm/boot/dts/keystone-k2l-clocks.dtsi b/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
index ef8464bb11ff..b3f82040a722 100644
--- a/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2013-2014 Texas Instruments, Inc.
- *
  * Keystone 2 lamarr SoC clock nodes
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
index e6de1ae33c73..61f63437b886 100644
--- a/arch/arm/boot/dts/keystone-k2l-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2014 Texas Instruments, Inc.
- *
  * Keystone 2 Lamarr EVM device tree
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
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
index cc771139c9ce..85b5481213d0 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2014 Texas Instruments, Inc.
- *
  * Keystone 2 Lamarr SoC specific device tree
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
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
