From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed, 15 Oct 2014 10:23:02 -0700
Subject: [PATCH v5 3/6] ARM: dts: rockchip: add pmu references to cpus nodes
In-Reply-To: <1413393785-26783-1-git-send-email-kever.yang@rock-chips.com>
References: <1413393785-26783-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1413393785-26783-4-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add pmu reference and enable-method for smp

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
- add this patch

Changes in v2: None

 arch/arm/boot/dts/rk3288.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 874e66d..bcfde19 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -46,6 +46,8 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "rockchip,rk3066-smp";
+		rockchip,pmu = <&pmu>;
 
 		cpu at 500 {
 			device_type = "cpu";
-- 
1.9.1
