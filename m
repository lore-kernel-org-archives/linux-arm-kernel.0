From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 23 May 2018 13:32:03 -0700
Subject: [PATCH v2 2/6] Documentation: DT: Add optional 'timeout-sec' property
 for sp805
In-Reply-To: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
References: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1527107527-8093-3-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the SP805 binding document to add optional 'timeout-sec'
devicetree property

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
index de93a4d..9cd7470 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
+++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
@@ -18,6 +18,8 @@ Required properties:
 
 Optional properties:
 - interrupts : Should specify WDT interrupt number.
+timeout-sec : Should specify default WDT timeout in seconds. If unset, the
+              default timeout in the driver is 30 seconds
 
 Example:
 	watchdog at 66090000 {
-- 
2.1.4
