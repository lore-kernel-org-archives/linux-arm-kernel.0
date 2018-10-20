From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Sun, 21 Oct 2018 06:36:05 +0900
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990-ebisu: Enable i2c
Message-ID: <1540071365-27533-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch enables I2C3 channels for the r8a77990-ebisu.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 611f026..4a596ef 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -294,6 +294,10 @@
 	clock-names = "fck", "dclkin.0", "extal";
 };
 
+&i2c3 {
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
1.9.1
