From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Fri, 18 Nov 2016 15:51:40 +0100
Subject: [PATCH v13 5/5] arm64: dt: hikey: Add optee node
In-Reply-To: <1479480700-554-1-git-send-email-jens.wiklander@linaro.org>
References: <1479480700-554-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1479480700-554-6-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jerome Forissier <jerome.forissier@linaro.org>

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index dba3c13..89c1539 100644
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
1.9.1
