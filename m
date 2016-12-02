From: briannorris@chromium.org (Brian Norris)
Date: Thu,  1 Dec 2016 18:27:26 -0800
Subject: [PATCH 2/9] arm64: dts: rockchip: add rk3399 thermal_zones phandle
In-Reply-To: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
Message-ID: <1480645653-36943-3-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're going to need to amend this table in board files.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 66a11d1a6eac..28772f6e77f0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -606,7 +606,7 @@
 		status = "disabled";
 	};
 
-	thermal-zones {
+	thermal_zones: thermal-zones {
 		cpu_thermal: cpu {
 			polling-delay-passive = <100>;
 			polling-delay = <1000>;
-- 
2.8.0.rc3.226.g39d4020
