From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 15 Jun 2017 23:39:12 -0700
Subject: [PATCH RESEND 1/2] dt-bindings: arm-ccn: Add bindings info for
 CCN-502 compatible string
In-Reply-To: <1497595153-18908-1-git-send-email-scott.branden@broadcom.com>
References: <1497595153-18908-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1497595153-18908-2-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Velibor Markovski <velibor.markovski@broadcom.com>

Add CCN-502 to the list of supported devices by ARM CCN PMU driver.

Signed-off-by: Velibor Markovski <velibor.markovski@broadcom.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
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
2.5.0
