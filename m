From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Wed,  3 May 2017 10:56:27 +0100
Subject: [PATCH v5 3/5] ARM: dts: rockchip: enable ARM Mali GPU on
 rk3288-rock2-som
In-Reply-To: <cover.1493804968.git.guillaume.tucker@collabora.com>
References: <cover.1493804968.git.guillaume.tucker@collabora.com>
Message-ID: <ca78af23d2a5fa38354129f49d8854b3af0a7cbc.1493804968.git.guillaume.tucker@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reference to the Mali GPU device tree node on the
rk3288-rock2-som platform.  Tested on a Radxa Rock2 Square board.

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 arch/arm/boot/dts/rk3288-rock2-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index 1c0bbc9b928b..f694867fa46a 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -301,3 +301,8 @@
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
