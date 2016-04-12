From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Apr 2016 07:55:44 +0800
Subject: [PATCH v4 08/16] arm64: dts: hikey: enable i2c0 and i2c1 for working
 with mezzanine boards
In-Reply-To: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
References: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1460505352-13157-9-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In HiKey board dts file, enable i2c0 and i2c1 for working with 96boards' LS
mezzanine.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 7545e36..3dbf51b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -45,6 +45,14 @@
 		spi0: spi at f7106000 {
 			status = "ok";
 		};
+
+		i2c0: i2c at f7100000 {
+			status = "ok";
+		};
+
+		i2c1: i2c at f7101000 {
+			status = "ok";
+		};
 	};
 };
 
-- 
1.9.1
