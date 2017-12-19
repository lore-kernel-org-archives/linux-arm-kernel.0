From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 19 Dec 2017 09:24:24 -0600
Subject: [PATCH 6/8] ARM: dts: dra72-evm-tps65917: Add cpu0 vdd supply
In-Reply-To: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1513697066-27732-7-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vdd-supply as smps12_reg for cpu0.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
index 57bfe5caf5e4..47bb90f41f3f 100644
--- a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
@@ -148,3 +148,7 @@
 &mmc1 {
 	vqmmc-supply = <&ldo1_reg>;
 };
+
+&cpu0 {
+	vdd-supply = <&smps1_reg>;
+};
-- 
2.15.1
