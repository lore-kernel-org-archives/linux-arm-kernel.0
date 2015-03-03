From: isubramanian@apm.com (Iyappan Subramanian)
Date: Tue,  3 Mar 2015 11:39:39 -0800
Subject: [PATCH v2 1/3] Documentation: dts: Update compatible field
 description for APM X-Gene
In-Reply-To: <1425411581-25463-1-git-send-email-isubramanian@apm.com>
References: <1425411581-25463-1-git-send-email-isubramanian@apm.com>
Message-ID: <1425411581-25463-2-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 Documentation/devicetree/bindings/net/apm-xgene-enet.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
index cfcc527..6151999 100644
--- a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
+++ b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
@@ -4,7 +4,10 @@ Ethernet nodes are defined to describe on-chip ethernet interfaces in
 APM X-Gene SoC.
 
 Required properties for all the ethernet interfaces:
-- compatible: Should be "apm,xgene-enet"
+- compatible: Should state binding information from the following list,
+  - "apm,xgene-enet":    RGMII based 1G interface
+  - "apm,xgene1-sgenet": SGMII based 1G interface
+  - "apm,xgene1-xgenet": XFI based 10G interface
 - reg: Address and length of the register set for the device. It contains the
   information of registers in the same order as described by reg-names
 - reg-names: Should contain the register set names
-- 
1.9.1
