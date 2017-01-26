From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Jan 2017 09:52:28 +0100
Subject: [PATCH 3/5] arm64: dts: r8a7796: salvator-x: Add I2C for DVFS device
 support
In-Reply-To: <1485420750-12701-1-git-send-email-horms+renesas@verge.net.au>
References: <1485420750-12701-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1485420750-12701-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dien Pham <dien.pham.ry@rvc.renesas.com>

This patch adds support of I2C for DVFS device for Salvator-X board on
R8A7796 SoC.

Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index c3e0b9e54a74..d7289613e21e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -262,3 +262,7 @@
 	timeout-sec = <60>;
 	status = "okay";
 };
+
+&i2c_dvfs {
+	status = "okay";
+};
-- 
2.7.0.rc3.207.g0ac5344
