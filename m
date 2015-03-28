From: contact@paulk.fr (Paul Kocialkowski)
Date: Sat, 28 Mar 2015 18:39:30 +0100
Subject: [PATCH 1/2] Documentation: devicetree: root node serial-number
 property documentation
Message-ID: <1427564371-26039-1-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 Documentation/devicetree/booting-without-of.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
index 7768518..8b055897 100644
--- a/Documentation/devicetree/booting-without-of.txt
+++ b/Documentation/devicetree/booting-without-of.txt
@@ -828,6 +828,10 @@ address which can extend beyond that limit.
   name may clash with standard defined ones, you prefix them with your
   vendor name and a comma.
 
+  Additional properties for the root node:
+
+    - serial-number : a string representing the board's serial number
+
   b) The /cpus node
 
   This node is the parent of all individual CPU nodes. It doesn't
-- 
1.9.1
