From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Tue, 22 Nov 2016 18:14:10 +0100
Subject: [PATCH 1/2] doc: DT: add generic serial property to disable DSR
In-Reply-To: <1479834851-32442-1-git-send-email-chf.fritz@googlemail.com>
References: <1479834851-32442-1-git-send-email-chf.fritz@googlemail.com>
Message-ID: <1479834851-32442-2-git-send-email-chf.fritz@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a generic serial property to disable DSR events which
can be necessary for buggy hardware.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 Documentation/devicetree/bindings/serial/serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/serial.txt b/Documentation/devicetree/bindings/serial/serial.txt
index fd970f7..26e274e 100644
--- a/Documentation/devicetree/bindings/serial/serial.txt
+++ b/Documentation/devicetree/bindings/serial/serial.txt
@@ -25,6 +25,8 @@ Optional properties:
     Note that this property is mutually-exclusive with "cts-gpios" and
     "rts-gpios" above.
 
+  - disable-dsr: The presence of this property disables DSR events reporting.
+
 
 Examples:
 
-- 
2.1.4
