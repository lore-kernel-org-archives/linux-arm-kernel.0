From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 16 Sep 2013 15:57:48 -0500
Subject: [PATCH] dts: Fix misspelling of Synopsys
Message-ID: <1379365068-18539-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

s/Synopsis/Synopsys
s/synopsis/synopsys

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Pavel Machek <pavel@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: devicetree at vger.kernel.org
Cc: linux-mmc at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   10 +++++-----
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   10 +++++-----
 .../{synopsis-dw-mshc.txt => synopsys-dw-mshc.txt} |    8 ++++----
 .../devicetree/bindings/pci/designware-pcie.txt    |    2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{synopsis-dw-mshc.txt => synopsys-dw-mshc.txt} (93%)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index 6d1c098..c67b975 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -1,11 +1,11 @@
-* Samsung Exynos specific extensions to the Synopsis Designware Mobile
+* Samsung Exynos specific extensions to the Synopsys Designware Mobile
   Storage Host Controller
 
-The Synopsis designware mobile storage host controller is used to interface
+The Synopsys designware mobile storage host controller is used to interface
 a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsis dw mshc controller properties described
-by synopsis-dw-mshc.txt and the properties used by the Samsung Exynos specific
-extensions to the Synopsis Designware Mobile Storage Host Controller.
+differences between the core Synopsys dw mshc controller properties described
+by synopsys-dw-mshc.txt and the properties used by the Samsung Exynos specific
+extensions to the Synopsys Designware Mobile Storage Host Controller.
 
 Required Properties:
 
diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index 8a3d91d..c559f3f 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -1,11 +1,11 @@
-* Rockchip specific extensions to the Synopsis Designware Mobile
+* Rockchip specific extensions to the Synopsys Designware Mobile
   Storage Host Controller
 
-The Synopsis designware mobile storage host controller is used to interface
+The Synopsys designware mobile storage host controller is used to interface
 a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsis dw mshc controller properties described
-by synopsis-dw-mshc.txt and the properties used by the Rockchip specific
-extensions to the Synopsis Designware Mobile Storage Host Controller.
+differences between the core Synopsys dw mshc controller properties described
+by synopsys-dw-mshc.txt and the properties used by the Rockchip specific
+extensions to the Synopsys Designware Mobile Storage Host Controller.
 
 Required Properties:
 
diff --git a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
similarity index 93%
rename from Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
rename to Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index cdcebea..066a78b 100644
--- a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -1,14 +1,14 @@
-* Synopsis Designware Mobile Storage Host Controller
+* Synopsys Designware Mobile Storage Host Controller
 
-The Synopsis designware mobile storage host controller is used to interface
+The Synopsys designware mobile storage host controller is used to interface
 a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
 differences between the core mmc properties described by mmc.txt and the
-properties used by the Synopsis Designware Mobile Storage Host Controller.
+properties used by the Synopsys Designware Mobile Storage Host Controller.
 
 Required Properties:
 
 * compatible: should be
-	- snps,dw-mshc: for controllers compliant with synopsis dw-mshc.
+	- snps,dw-mshc: for controllers compliant with synopsys dw-mshc.
 * #address-cells: should be 1.
 * #size-cells: should be 0.
 
diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index eabcb4b..e216af3 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -1,4 +1,4 @@
-* Synopsis Designware PCIe interface
+* Synopsys Designware PCIe interface
 
 Required properties:
 - compatible: should contain "snps,dw-pcie" to identify the
-- 
1.7.9.5
