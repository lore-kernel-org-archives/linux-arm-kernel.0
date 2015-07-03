From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat,  4 Jul 2015 01:15:20 +0200
Subject: [PATCH v4 7/7] apf27: dt: enable support of internal rtc
In-Reply-To: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
References: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1435965320-1478-8-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support of internal rtc on armadeus apf27.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 arch/arm/boot/dts/imx27-apf27.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index 73aae4f..590d37a 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -122,3 +122,7 @@
 		reg = <0x800000 0xf800000>;
 	};
 };
+
+&rtc {
+	status = "okay";
+};
-- 
1.7.4.4
