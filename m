From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Sat, 28 Jan 2017 13:19:44 +0100
Subject: [PATCH v15 5/5] arm64: dt: hikey: Add optee node
In-Reply-To: <1485605984-30064-1-git-send-email-jens.wiklander@linaro.org>
References: <1485605984-30064-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1485605984-30064-6-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jerome Forissier <jerome.forissier@linaro.org>

Acked-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index dba3c131c62c..89c15399bec2 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -406,6 +406,13 @@
 			};
 		};
 	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
 };
 
 &uart2 {
-- 
2.7.4
