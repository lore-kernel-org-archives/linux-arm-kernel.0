From: phh@phh.me (Pierre-Hugues Husson)
Date: Sat, 14 Oct 2017 00:53:37 +0200
Subject: [PATCH 3/3] arm64: dts: rockchip: enable cec pin for rk3399 firefly
In-Reply-To: <20171013225337.5196-1-phh@phh.me>
References: <20171013225337.5196-1-phh@phh.me>
Message-ID: <20171013225337.5196-4-phh@phh.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Pierre-Hugues Husson <phh@phh.me>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index f6fbcc05073e..431ff1bb3720 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -257,6 +257,8 @@
 
 &hdmi {
 	ddc-i2c-bus = <&i2c3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec>;
 	status = "okay";
 };
 
-- 
2.14.1
