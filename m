From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 26 Dec 2017 19:56:56 -0800
Subject: [PATCH 2/2] ARM: dts: imx6: RDU2: correct RTC compatible
In-Reply-To: <20171227035656.4941-1-andrew.smirnov@gmail.com>
References: <20171227035656.4941-1-andrew.smirnov@gmail.com>
Message-ID: <20171227035656.4941-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC is manufactured by Maxim. This is a cosmetic fix, as Linux
doesn't match the vendor string for i2c devices.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: cphealy at gmail.com
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index eef737bd52d9..6bef9a98678e 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -581,7 +581,7 @@
 	};
 
 	ds1341: rtc at 68 {
-		compatible = "dallas,ds1341";
+		compatible = "maxim,ds1341";
 		reg = <0x68>;
 	};
 };
