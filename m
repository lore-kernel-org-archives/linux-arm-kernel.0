From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sun, 6 Sep 2015 17:34:34 +0800
Subject: [PATCH v3 1/2] arm64: hip05-d02: Document devicetree bindings for
 Hisilicon Hip05-D02 Board
In-Reply-To: <1441532075-9452-1-git-send-email-dingtianhong@huawei.com>
References: <1441532075-9452-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1441532075-9452-2-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the devicetree bindings used by the
DT files of Hisilicon Hip05-D02 development board.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index c431c67..f98b39d 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -20,6 +20,10 @@ HiKey Board
 Required root node properties:
 	- compatible = "hisilicon,hi6220-hikey", "hisilicon,hi6220";
 
+HiP05 D02 Board
+Required root node properties:
+	- compatible = "hisilicon,hip05-d02";
+
 Hisilicon system controller
 
 Required properties:
-- 
1.9.0
