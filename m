From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 11 Sep 2015 12:20:51 +0000
Subject: [PATCH 2/4] dt/bindings: serial: of-serial: add description for
 clock-divider property
In-Reply-To: <1441974053-2630-1-git-send-email-kernel@martin.sperl.org>
References: <1441974053-2630-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1441974053-2630-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add description for clock-divider to the binding documentation.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 Documentation/devicetree/bindings/serial/8250.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 91d5ab0..2c6eaec 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -43,6 +43,7 @@ Optional properties:
 - auto-flow-control: one way to enable automatic flow control support. The
   driver is allowed to detect support for the capability even without this
   property.
+- clock-divider: set an alternative clock divider instead of the default 16
 
 Note:
 * fsl,ns16550:
-- 
1.7.10.4
