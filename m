From: Anson.Huang@nxp.com (Anson Huang)
Date: Sat,  5 May 2018 16:29:18 +0800
Subject: [PATCH V6 2/7] ARM: dts: imx6sx-sabreauto: add max7322 IO expander
 support
In-Reply-To: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1525508963-7986-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MAX7322 IO expander support.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 1d8cf0f..ae253af 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -254,4 +254,11 @@
 			};
 		};
 	};
+
+	max7322: gpio at 68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
2.7.4
