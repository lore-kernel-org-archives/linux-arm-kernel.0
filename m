From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 8 Apr 2016 15:27:12 +0800
Subject: [PATCH 2/2] Documentation: arm64: Add Hisilicon Hip06 D03 dts binding
In-Reply-To: <1460100432-52722-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460100432-52722-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1460100432-52722-3-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the devicetree bindings used by
the DT files of Hisilicon Hip06 D03 board.

Meanwhile, reorder the soc/board name alphabetically.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 .../devicetree/bindings/arm/hisilicon/hisilicon.txt  | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index e3ccab1..83fe816 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -1,29 +1,33 @@
 Hisilicon Platforms Device Tree Bindings
 ----------------------------------------------------
-Hi6220 SoC
-Required root node properties:
-	- compatible = "hisilicon,hi6220";
-
 Hi4511 Board
 Required root node properties:
 	- compatible = "hisilicon,hi3620-hi4511";
 
-HiP04 D01 Board
+Hi6220 SoC
 Required root node properties:
-	- compatible = "hisilicon,hip04-d01";
+	- compatible = "hisilicon,hi6220";
+
+HiKey Board
+Required root node properties:
+	- compatible = "hisilicon,hi6220-hikey", "hisilicon,hi6220";
 
 HiP01 ca9x2 Board
 Required root node properties:
 	- compatible = "hisilicon,hip01-ca9x2";
 
-HiKey Board
+HiP04 D01 Board
 Required root node properties:
-	- compatible = "hisilicon,hi6220-hikey", "hisilicon,hi6220";
+	- compatible = "hisilicon,hip04-d01";
 
 HiP05 D02 Board
 Required root node properties:
 	- compatible = "hisilicon,hip05-d02";
 
+HiP06 D03 Board
+Required root node properties:
+	- compatible = "hisilicon,hip06-d03";
+
 Hisilicon system controller
 
 Required properties:
-- 
1.7.12.4
