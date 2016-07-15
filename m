From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 15 Jul 2016 16:10:27 -0600
Subject: [PATCH v2] media: Doc add missing documentation for samsung,
 exynos4212-jpeg
Message-ID: <1468620627-9750-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add add missing documentation for samsung,exynos4212-jpeg codec,
reorder entries to improve readability and make it easier to add
new entries.

samsung,exynos4212-jpeg and samsung,exynos4210-jpeg are identical,
hence add samsung,exynos4212-jpeg as deprecated in the documentation.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---

Changes since v1:
- Added samsung,exynos4212-jpeg as deprecated

 Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt b/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
index 38941db..c5399e7 100644
--- a/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
+++ b/Documentation/devicetree/bindings/media/exynos-jpeg-codec.txt
@@ -3,9 +3,11 @@ Samsung S5P/EXYNOS SoC series JPEG codec
 Required properties:
 
 - compatible	: should be one of:
-		  "samsung,s5pv210-jpeg", "samsung,exynos4210-jpeg",
-		  "samsung,exynos3250-jpeg", "samsung,exynos5420-jpeg",
+		  "samsung,s5pv210-jpeg", "samsung,exynos3250-jpeg",
+		  "samsung,exynos4210-jpeg", "samsung,exynos5420-jpeg",
 		  "samsung,exynos5433-jpeg";
+
+		  (Deprecated: "samsung,exynos4212-jpeg").
 - reg		: address and length of the JPEG codec IP register set;
 - interrupts	: specifies the JPEG codec IP interrupt;
 - clock-names   : should contain:
-- 
2.7.4
