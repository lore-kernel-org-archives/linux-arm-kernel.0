From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 14 Jun 2017 16:23:34 +0800
Subject: [PATCH v3 17/21] dt-bindings: mfd: hi6421: Add hi6421v530 compatible
 string
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Message-ID: <20170614082338.15673-18-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible string for HiSilicon Hi6421v530 PMIC.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Acked-for-mfd-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/devicetree/bindings/mfd/hi6421.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/hi6421.txt b/Documentation/devicetree/bindings/mfd/hi6421.txt
index 0d5a446..22da96d 100644
--- a/Documentation/devicetree/bindings/mfd/hi6421.txt
+++ b/Documentation/devicetree/bindings/mfd/hi6421.txt
@@ -1,7 +1,9 @@
 * HI6421 Multi-Functional Device (MFD), by HiSilicon Ltd.
 
 Required parent device properties:
-- compatible	: contains "hisilicon,hi6421-pmic";
+- compatible    : One of the following chip-specific strings:
+	"hisilicon,hi6421-pmic";
+	"hisilicon,hi6421v530-pmic";
 - reg		: register range space of hi6421;
 
 Supported Hi6421 sub-devices include:
-- 
2.10.2
