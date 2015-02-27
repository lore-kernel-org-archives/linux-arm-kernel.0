From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 27 Feb 2015 12:08:28 -0800
Subject: [PATCH 1/3] Documentation: dts: Update compatible field description
 for APM X-Gene
In-Reply-To: <1425067710-14879-1-git-send-email-isubramanian@apm.com>
References: <1425067710-14879-1-git-send-email-isubramanian@apm.com>
Message-ID: <1425067710-14879-2-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 Documentation/devicetree/bindings/net/apm-xgene-enet.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
index cfcc527..5355996 100644
--- a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
+++ b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
@@ -4,7 +4,8 @@ Ethernet nodes are defined to describe on-chip ethernet interfaces in
 APM X-Gene SoC.
 
 Required properties for all the ethernet interfaces:
-- compatible: Should be "apm,xgene-enet"
+- compatible: Should be "apm,xgene-enet", "apm,xgene1-sgenet" or
+  "apm,xgene1-xgenet"
 - reg: Address and length of the register set for the device. It contains the
   information of registers in the same order as described by reg-names
 - reg-names: Should contain the register set names
-- 
1.9.1
