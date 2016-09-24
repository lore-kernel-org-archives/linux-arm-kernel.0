From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sat, 24 Sep 2016 17:14:22 +0800
Subject: [PATCH 2/5] Documentation: arm64: Add Hisilicon Hip07 D05 dts binding
In-Reply-To: <1474708465-38958-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1474708465-38958-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1474708465-38958-3-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the devicetree bindings used by
the DT files of Hisilicon Hip07 D05 board.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 3f81575..7df79a7 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -28,6 +28,10 @@ HiP06 D03 Board
 Required root node properties:
 	- compatible = "hisilicon,hip06-d03";
 
+HiP07 D05 Board
+Required root node properties:
+	- compatible = "hisilicon,hip07-d05";
+
 Hisilicon system controller
 
 Required properties:
-- 
1.7.12.4
