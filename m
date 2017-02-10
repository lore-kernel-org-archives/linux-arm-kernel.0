From: velibor.markovski@broadcom.com (Velibor Markovski)
Date: Fri, 10 Feb 2017 12:36:26 -0800
Subject: [PATCH INTERNAL 1/2] dt-bindings: arm-ccn: Add bindings info for
 CCN-502 compatible string
In-Reply-To: <1486758987-23769-1-git-send-email-velibor.markovski@broadcom.com>
References: <1486758987-23769-1-git-send-email-velibor.markovski@broadcom.com>
Message-ID: <1486758987-23769-2-git-send-email-velibor.markovski@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CCN-502 to the list of supported devices by ARM CCN PMU driver.

Signed-off-by: Velibor Markovski <velibor.markovski@broadcom.com>
---
 Documentation/devicetree/bindings/arm/ccn.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ccn.txt b/Documentation/devicetree/bindings/arm/ccn.txt
index b100d38..2980145 100644
--- a/Documentation/devicetree/bindings/arm/ccn.txt
+++ b/Documentation/devicetree/bindings/arm/ccn.txt
@@ -3,6 +3,7 @@
 Required properties:
 
 - compatible: (standard compatible string) should be one of:
+	"arm,ccn-502"
 	"arm,ccn-504"
 	"arm,ccn-508"
 
-- 
1.9.1
