From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Sun,  2 Apr 2017 08:59:47 +0100
Subject: [PATCH v2 4/5] ARM: dts: rockchip: enable ARM Mali GPU on
 rk3288-firefly
In-Reply-To: <cover.1491118230.git.guillaume.tucker@collabora.com>
References: <cover.1491118230.git.guillaume.tucker@collabora.com>
Message-ID: <22d0e8ec1216e09aba803d2520f6bbe34b70171b.1491118230.git.guillaume.tucker@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reference to the Mali GPU device tree node on rk3288-firefly.
Tested on Firefly board.

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 10793ac18599..f520589493b4 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -594,3 +594,8 @@
 &wdt {
 	status = "okay";
 };
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
-- 
2.11.0
