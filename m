From: yegorslists@googlemail.com (yegorslists at googlemail.com)
Date: Mon, 10 Mar 2014 16:26:57 +0100
Subject: [PATCH] ARM: dts: am335x-evmsk: enable DMA controller for USB
Message-ID: <1394465217-24171-1-git-send-email-yegorslists@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index fa19271..ec08f6f 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -384,6 +384,10 @@
 		status = "okay";
 		dr_mode = "host";
 	};
+
+	dma-controller at 07402000  {
+		status = "okay";
+	};
 };
 
 &epwmss2 {
-- 
1.7.7
