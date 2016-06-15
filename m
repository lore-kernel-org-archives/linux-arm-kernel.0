From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 15 Jun 2016 21:28:53 +0800
Subject: [PATCH 3/3] ARM: dts: rockchip: enable hdmi audio on rk3036-kylin
In-Reply-To: <1465997312-17777-1-git-send-email-ykk@rock-chips.com>
References: <1465997312-17777-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1465997333-17883-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the basic hdmi audio function on rk3036 kylin board.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 arch/arm/boot/dts/rk3036-kylin.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 1df1557..070cfe1 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -139,6 +139,10 @@
 	status = "okay";
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 
-- 
1.9.1
