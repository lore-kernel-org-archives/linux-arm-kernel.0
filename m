From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Wed, 15 Nov 2017 17:12:01 +0800
Subject: [PATCH v1] ARM: dts: ls1021a: Enable the esdhc
Message-ID: <20171115091201.48418-1-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "yinbo.zhu" <yinbo.zhu@nxp.com>

Ls1021a esdhc had been enabled in uboot,
but it had not been enabled it in kernel,
So set the esdhc's status to "okay".

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a8b148ad1dd2..f7946f40d35d 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -228,6 +228,10 @@
 	};
 };
 
+&esdhc {
+        status = "okay";
+};
+
 &sai1 {
 	status = "okay";
 };
-- 
2.14.1
