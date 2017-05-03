From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Wed,  3 May 2017 10:56:28 +0100
Subject: [PATCH v5 4/5] ARM: dts: rockchip: enable ARM Mali GPU on
 rk3288-firefly
In-Reply-To: <cover.1493804968.git.guillaume.tucker@collabora.com>
References: <cover.1493804968.git.guillaume.tucker@collabora.com>
Message-ID: <efabc1d3e78ba834923dd4cae5a35ab7c07ad9bb.1493804968.git.guillaume.tucker@collabora.com>
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
