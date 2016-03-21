From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 21 Mar 2016 17:42:45 +0800
Subject: [RFC PATCH v1 4/4] ARM: dst: rockchip: enable RGA support on veyron
 devices
In-Reply-To: <1458552518-25527-1-git-send-email-ykk@rock-chips.com>
References: <1458552518-25527-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1458553365-27252-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 9fce91f..5eb4e97 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -425,6 +425,10 @@
 	dr_mode = "host";
 };
 
+&rga {
+	status = "okay";
+};
+
 &vopb {
 	status = "okay";
 };
-- 
1.9.1
