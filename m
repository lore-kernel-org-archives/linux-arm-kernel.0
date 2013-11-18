From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 18 Nov 2013 12:46:12 +0100
Subject: [PATCH] clk: exynos: Fix typos in DT bindings documentation
Message-ID: <1384775172-3373-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s/comptible/compatible/

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 Documentation/devicetree/bindings/clock/exynos4-clock.txt    | 2 +-
 Documentation/devicetree/bindings/clock/exynos5250-clock.txt | 2 +-
 Documentation/devicetree/bindings/clock/exynos5420-clock.txt | 2 +-
 Documentation/devicetree/bindings/clock/exynos5440-clock.txt | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos4-clock.txt b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
index c6bf8a6..a2ac2d9 100644
--- a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
@@ -6,7 +6,7 @@ SoC's in the Exynos4 family.
 
 Required Properties:
 
-- comptible: should be one of the following.
+- compatible: should be one of the following.
   - "samsung,exynos4210-clock" - controller compatible with Exynos4210 SoC.
   - "samsung,exynos4412-clock" - controller compatible with Exynos4412 SoC.
 
diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
index 24765c1..46f5c79 100644
--- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
@@ -5,7 +5,7 @@ controllers within the Exynos5250 SoC.
 
 Required Properties:
 
-- comptible: should be one of the following.
+- compatible: should be one of the following.
   - "samsung,exynos5250-clock" - controller compatible with Exynos5250 SoC.
 
 - reg: physical base address of the controller and length of memory mapped
diff --git a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
index 32aa34e..458f347 100644
--- a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
@@ -5,7 +5,7 @@ controllers within the Exynos5420 SoC.
 
 Required Properties:
 
-- comptible: should be one of the following.
+- compatible: should be one of the following.
   - "samsung,exynos5420-clock" - controller compatible with Exynos5420 SoC.
 
 - reg: physical base address of the controller and length of memory mapped
diff --git a/Documentation/devicetree/bindings/clock/exynos5440-clock.txt b/Documentation/devicetree/bindings/clock/exynos5440-clock.txt
index 4499e99..9955dc9 100644
--- a/Documentation/devicetree/bindings/clock/exynos5440-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5440-clock.txt
@@ -5,7 +5,7 @@ controllers within the Exynos5440 SoC.
 
 Required Properties:
 
-- comptible: should be "samsung,exynos5440-clock".
+- compatible: should be "samsung,exynos5440-clock".
 
 - reg: physical base address of the controller and length of memory mapped
   region.
-- 
1.8.3.2
