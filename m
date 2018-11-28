From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 28 Nov 2018 09:57:45 +0000
Subject: [PATCH V3 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
In-Reply-To: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
References: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1543398696-3140-5-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i.MX8QXP system controller RTC support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index da99b6f..5e8b554 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -406,4 +406,8 @@
 		#size-cells = <1>;
 		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
 	};
+
+	rtc: rtc {
+		compatible = "nxp,imx8qxp-sc-rtc";
+	};
 };
-- 
2.7.4
