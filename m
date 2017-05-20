From: cosardindar@gmail.com (Cosar Dindar)
Date: Sat, 20 May 2017 16:33:00 +0300
Subject: [PATCH v2 4/5] ARM: dts: stm32: enable CRC32 on stm32429i-eval board
In-Reply-To: <cover.1495285223.git.cosardindar@gmail.com>
References: <cover.1495285223.git.cosardindar@gmail.com>
Message-ID: <d613a2e3dc35f1143614f2885aa218220f32b8b7.1495285223.git.cosardindar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the CRC32 crypto on stm32429i-eval board.

Signed-off-by: Cosar Dindar <cosardindar@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index b633114..360fb19 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -141,6 +141,10 @@
 	clock-frequency = <25000000>;
 };
 
+&crc {
+	status = "okay";
+};
+
 &i2c1 {
 	pinctrl-0 = <&i2c1_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
