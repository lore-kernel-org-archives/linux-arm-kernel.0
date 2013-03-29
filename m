From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Fri, 29 Mar 2013 09:23:39 +0100
Subject: [PATCH 2/2] ARM: apf27dev: add PWM0 support
In-Reply-To: <1364545419-21558-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1364545419-21558-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1364545419-21558-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx27-apf27dev.dtsp | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dtsp b/arch/arm/boot/dts/imx27-apf27dev.dtsp
index 65d1853..3e60eba 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dtsp
+++ b/arch/arm/boot/dts/imx27-apf27dev.dtsp
@@ -58,3 +58,7 @@
 &i2c2 {
 	status = "okay";
 };
+
+&pwm0 {
+	status = "okay";
+};
-- 
1.8.1.5
