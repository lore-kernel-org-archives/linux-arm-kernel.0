From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 24 May 2010 04:30:02 +0100
Subject: [PATCH 1/8] ARM: SAMSUNG: Documentation: update the list of SoCs
	supported
In-Reply-To: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
References: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274671809-9821-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the list of SoCs supported for the plat-s5p range.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 Documentation/arm/Samsung/Overview.txt |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm/Samsung/Overview.txt b/Documentation/arm/Samsung/Overview.txt
index 7cced1f..e8c5dfc 100644
--- a/Documentation/arm/Samsung/Overview.txt
+++ b/Documentation/arm/Samsung/Overview.txt
@@ -13,9 +13,10 @@ Introduction
 
   - S3C24XX: See Documentation/arm/Samsung-S3C24XX/Overview.txt for full list
   - S3C64XX: S3C6400 and S3C6410
-  - S5PC6440
-
-  S5PC100 and S5PC110 support is currently being merged
+  - S5P6440
+  - S5P6442
+  - S5PC100
+  - S5PC110 / S5PV210
 
 
 S3C24XX Systems
@@ -35,7 +36,10 @@ Configuration
   unifying all the SoCs into one kernel.
 
   s5p6440_defconfig - S5P6440 specific default configuration
+  s5p6442_defconfig - S5P6442 specific default configuration
   s5pc100_defconfig - S5PC100 specific default configuration
+  s5pc110_defconfig - S5PC110 specific default configuration
+  s5pv210_defconfig - S5PV210 specific default configuration
 
 
 Layout
-- 
1.6.3.3
