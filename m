From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 24 Nov 2014 19:57:48 +0900
Subject: [PATCHv3 1/3] ARM: exynos: Add Exynos-based boards compatible string
 and description
In-Reply-To: <1416826670-29438-1-git-send-email-cw00.choi@samsung.com>
References: <1416826670-29438-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1416826670-29438-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing compatible/description of Exynos-based boards
to remove following build warning.

	WARNING: DT compatible string "samsung,..." appears un-documented --
	check ./Documentation/devicetree/bindings/

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../devicetree/bindings/arm/samsung-boards.txt         | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung-boards.txt
index 2168ed3..1f8287e 100644
--- a/Documentation/devicetree/bindings/arm/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung-boards.txt
@@ -1,11 +1,19 @@
-* Samsung's Exynos4210 based SMDKV310 evaluation board
-
-SMDKV310 evaluation board is based on Samsung's Exynos4210 SoC.
+* Samsung's Exynos SoC based boards
 
 Required root node properties:
     - compatible = should be one or more of the following.
-        (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
-        (b) "samsung,exynos4210"  - for boards based on Exynos4210 SoC.
+	- "samsung,rinato"	- for Exynos3250-based Samsung Gear2 board.
+	- "samsung,smdkv310"	- for Exynos4210-based Samsung SMDKV310 eval board.
+	- "samsung,trats"	- for Exynos4210-based Tizen Reference board.
+	- "samsung,universal_c210" - for Exynos4210-based Samsung board.
+	- "samsung,smdk4412",	- for Exynos4412-based Samsung SMDK4412 eval board.
+	- "samsung,trats2"	- for Exynos4412-based Tizen Reference board.
+	- "samsung,smdk5250"	- for Exynos5250-based Samsung SMDK5250 eval board.
+	- "samsung,xyref5260"	- for Exynos5260-based Samsung board.
+	- "samsung,smdk5410"	- for Exynos5410-based Samsung SMDK5410 eval board.
+	- "samsung,smdk5420"	- for Exynos5420-based Samsung SMDK5420 eval board.
+	- "samsung,sd5v1"	- for Exynos5440-based Samsung board.
+	- "samsung,ssdk5440"	- for Exynos5440-based Samsung board.
 
 Optional:
     - firmware node, specifying presence and type of secure firmware:
-- 
1.8.5.5
