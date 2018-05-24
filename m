From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 23 May 2018 17:15:20 -0700
Subject: [PATCH v3 2/6] Documentation: DT: Add optional 'timeout-sec' property
 for sp805
In-Reply-To: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
References: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1527120924-12131-3-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the SP805 binding document to add optional 'timeout-sec'
devicetree property

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
index 0fa3629..1debea3 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
+++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
@@ -19,6 +19,8 @@ Required properties:
 
 Optional properties:
 - interrupts:  Should specify WDT interrupt number
+- timeout-sec: Should specify default WDT timeout in seconds. If unset, the
+               default timeout in the driver is 30 seconds
 
 Example:
 	watchdog at 66090000 {
-- 
2.1.4
