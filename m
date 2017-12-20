From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:53:20 +1030
Subject: [PATCH v3 12/20] ARM: dts: aspeed: Update license headers
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-13-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier
to files with no license") these files had the GPL-2.0 licence added
automatically. Update them to be GPL 2.0+ in line with other IBM kernel
contributions.

Reviewed-by: C?dric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts      | 2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  | 2 +-
 arch/arm/boot/dts/aspeed-g4.dtsi              | 2 +-
 arch/arm/boot/dts/aspeed-g5.dtsi              | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 602bc10fdaf4..3e6f38e5d5d0 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 /dts-v1/;
 
 #include "aspeed-g5.dtsi"
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index c786bc2f2919..a8f0c046e83e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 /dts-v1/;
 
 #include "aspeed-g4.dtsi"
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 8067793129ea..a7a9386f964d 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 /dts-v1/;
 
 #include "aspeed-g5.dtsi"
diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 1186fe55e2d8..b0d8431a3700 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 #include <dt-bindings/clock/aspeed-clock.h>
 
 / {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 6043876ad85f..40de3b66c33f 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 #include <dt-bindings/clock/aspeed-clock.h>
 
 / {
-- 
2.15.1
