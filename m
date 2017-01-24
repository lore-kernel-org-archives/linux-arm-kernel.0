From: puck.chen@hisilicon.com (Chen Feng)
Date: Tue, 24 Jan 2017 16:57:29 +0800
Subject: [V3 3/3] dt-bindings: Add a support cpu type for cortex-a73
In-Reply-To: <1485248249-117383-1-git-send-email-puck.chen@hisilicon.com>
References: <1485248249-117383-1-git-send-email-puck.chen@hisilicon.com>
Message-ID: <1485248249-117383-3-git-send-email-puck.chen@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add arm cpu type cortex-a73

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index a1bcfee..d748774 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -158,6 +158,7 @@ nodes to be present and contain the properties described below.
 			    "arm,cortex-a53"
 			    "arm,cortex-a57"
 			    "arm,cortex-a72"
+			    "arm,cortex-a73"
 			    "arm,cortex-m0"
 			    "arm,cortex-m0+"
 			    "arm,cortex-m1"
-- 
1.9.1
