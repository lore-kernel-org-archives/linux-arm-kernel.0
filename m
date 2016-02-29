From: brad.mouring@ni.com (Brad Mouring)
Date: Mon, 29 Feb 2016 10:01:56 -0600
Subject: [PATCH 2/2] Documentation: devicetree: Add PL310 PM bindings
In-Reply-To: <1456761716-10174-1-git-send-email-brad.mouring@ni.com>
References: <1456265019-23900-1-git-send-email-brad.mouring@ni.com>
 <1456761716-10174-1-git-send-email-brad.mouring@ni.com>
Message-ID: <1456761716-10174-2-git-send-email-brad.mouring@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the DT bindings for controlling ARM PL310 Power Control
settings.

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Acked-by: Josh Cartwright <joshc@ni.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/l2c2x0.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
index fe0398c..6b2366ed 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
@@ -84,6 +84,10 @@ Optional properties:
 - prefetch-instr : Instruction prefetch. Value: <0> (forcibly disable),
   <1> (forcibly enable), property absent (retain settings set by
   firmware)
+- arm,dynamic-clock-gating : L2 dynamic clock gating. Value: <0> (forcibly
+  disable), <1> (forcibly enable), property absent (retain firmware settings)
+- arm,standby-mode: L2 standby mode enable. Value <0> (forcibly disable),
+  <1> (forcibly enable), property absent (retain firmware settings)
 
 Example:
 
-- 
2.7.1
