From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 29 Mar 2016 23:50:45 +0200
Subject: [PATCH 6/7] ARM: dts: lpc4357-ea4357: add dac
In-Reply-To: <1459288246-1670-1-git-send-email-manabian@gmail.com>
References: <1459288246-1670-1-git-send-email-manabian@gmail.com>
Message-ID: <1459288246-1670-7-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the DAC on the EA4357 dev kit.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index bbc70b9..a211b6e 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -495,6 +495,11 @@
 	};
 };
 
+&dac {
+	status = "okay";
+	vref-supply = <&vcc>;
+};
+
 &emc {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.7.4
