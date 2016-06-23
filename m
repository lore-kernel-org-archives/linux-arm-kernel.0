From: megous@megous.com (megous at megous.com)
Date: Thu, 23 Jun 2016 21:20:59 +0200
Subject: [PATCH 09/14] ARM: dts: sun8i: Enable r_twi on Orange Pi PC
In-Reply-To: <20160623192104.18720-1-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
Message-ID: <20160623192104.18720-10-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

Enable I2C controller where the SY8106A regulator for
CPUX voltage is attached on Orange Pi PC SBC.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index daf50b9a6..e5991da 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -90,6 +90,10 @@
 	};
 };
 
+&r_twi {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
-- 
2.9.0
