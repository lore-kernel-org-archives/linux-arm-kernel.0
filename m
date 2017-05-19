From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 17:58:04 +0200
Subject: [PATCH 4/5] arm64: dts: marvell: remove clock-output-names on ap806
In-Reply-To: <cover.fd6093dbad53cdac70eef4e53b238768721218ac.1495209464.git-series.gregory.clement@free-electrons.com>
References: <cover.fd6093dbad53cdac70eef4e53b238768721218ac.1495209464.git-series.gregory.clement@free-electrons.com>
Message-ID: <f82d7cab7f94b7884334abc7485fc7f2d775c9dd.1495209464.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock-output-names of the ap806-system-controller node are not used
anymore, so remove them.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index fe41bf9c301e..0c25ec62a2a3 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -244,10 +244,6 @@
 				compatible = "marvell,ap806-system-controller",
 					     "syscon";
 				#clock-cells = <1>;
-				clock-output-names = "ap-cpu-cluster-0",
-						     "ap-cpu-cluster-1",
-						     "ap-fixed", "ap-mss",
-						     "ap-emmc";
 				reg = <0x6f4000 0x1000>;
 			};
 		};
-- 
git-series 0.9.1
