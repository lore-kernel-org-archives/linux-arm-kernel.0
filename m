From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  3 Jun 2013 14:42:27 +0100
Subject: [PATCH 03/21] ARM: ux500: Supply the TWD Timer clock lookup to the
 DBX500 DT
In-Reply-To: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370266965-7901-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 6c445d5..6eec1cd 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -45,6 +45,8 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xa0410600 0x20>;
 			interrupts = <1 13 0x304>;
+
+			clocks = <&clk 39>;
 		};
 
 		rtc at 80154000 {
-- 
1.7.10.4
