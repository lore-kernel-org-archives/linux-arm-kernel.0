From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue,  5 Apr 2016 21:27:32 +0800
Subject: [PATCH v3 08/16] arm64: dts: hikey: enable i2c0 and i2c1 for working
 with mezzanine boards
In-Reply-To: <1459862860-9775-1-git-send-email-guodong.xu@linaro.org>
References: <1459862860-9775-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1459862860-9775-9-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 5c9ee31..e00e9ec 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -42,6 +42,15 @@
 		      <0x00000000 0x06e00000 0x00000000 0x0060f000>,
 		      <0x00000000 0x07410000 0x00000000 0x36bf0000>;
 	};
+
+	soc {
+		i2c0: i2c at f7100000 {
+			status = "ok";
+		};
+		i2c1: i2c at f7101000 {
+			status = "ok";
+		};
+	};
 };
 
 &uart2 {
-- 
1.9.1
