From: brad.mouring@ni.com (Brad Mouring)
Date: Wed, 27 Apr 2016 10:35:51 -0500
Subject: [PATCH 2/2] Documentation: devicetree: Add PL310 PM bindings
In-Reply-To: <1461771351-11645-1-git-send-email-brad.mouring@ni.com>
References: <1461015411-14000-1-git-send-email-brad.mouring@ni.com>
 <1461771351-11645-1-git-send-email-brad.mouring@ni.com>
Message-ID: <1461771351-11645-3-git-send-email-brad.mouring@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the DT bindings for controlling ARM PL310 Power Control
settings.

Discussion on the binding wording:
http://archive.arm.linux.org.uk/lurker/message/20160427.143444.5141d302.en.html

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
---
 Documentation/devicetree/bindings/arm/l2c2x0.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
index fe0398c..c453ab5 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
@@ -84,6 +84,12 @@ Optional properties:
 - prefetch-instr : Instruction prefetch. Value: <0> (forcibly disable),
   <1> (forcibly enable), property absent (retain settings set by
   firmware)
+- arm,dynamic-clock-gating : L2 dynamic clock gating. Value: <0> (forcibly
+  disable), <1> (forcibly enable), property absent (OS specific behavior,
+  preferrably retain firmware settings)
+- arm,standby-mode: L2 standby mode enable. Value <0> (forcibly disable),
+  <1> (forcibly enable), property absent (OS specific behavior,
+  preferrably retain firmware settings)
 
 Example:
 
-- 
2.7.3
