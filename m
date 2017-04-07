From: andy.yan@rock-chips.com (Andy Yan)
Date: Fri,  7 Apr 2017 16:19:29 +0800
Subject: [PATCH] arm64: dts: rockchip: fix the memory size of PX5 Evaluation
 board
Message-ID: <1491553169-21106-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 122682b2abb6 ("arm64: dts: rockchip: Add PX5 Evaluation board")
sets the memory size to 2 GB, but this board only has 1 GB DRAM, so change
it to the correct value here.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
index 3ffa71d..a5fe600 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
@@ -53,7 +53,7 @@
 	};
 
 	memory at 0 {
-		reg = <0x0 0x0 0x0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x40000000>;
 		device_type = "memory";
 	};
 
-- 
2.7.4
