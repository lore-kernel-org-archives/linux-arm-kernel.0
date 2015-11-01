From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Sun,  1 Nov 2015 16:53:52 +0300
Subject: [PATCH] ARM: dts: sun7i: Enable audio codec on Wexler TAB7200 tablet.
Message-ID: <1446386032-19839-1-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable on-chip audio codec on the Wexler TAB7200 tablet.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index 90952ab..69f0a2c 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -75,6 +75,10 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
-- 
2.4.9
