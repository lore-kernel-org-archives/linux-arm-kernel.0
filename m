From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 12 Aug 2016 22:05:46 -0700
Subject: [PATCH net-next v2 10/12] Documentation: dtb: xgene: Add rxlos GPIO
 mapping
In-Reply-To: <1471064748-28033-1-git-send-email-isubramanian@apm.com>
References: <1471064748-28033-1-git-send-email-isubramanian@apm.com>
Message-ID: <1471064748-28033-11-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Quan Nguyen <qnguyen@apm.com>
Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Tested-by: Fushen Chen <fchen@apm.com>
---
 Documentation/devicetree/bindings/net/apm-xgene-enet.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
index e41b2d5..f591ab7 100644
--- a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
+++ b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
@@ -47,6 +47,9 @@ Optional properties:
 	    Valid values are between 0 to 7, that maps to
 	    273, 589, 899, 1222, 1480, 1806, 2147, 2464 ps
 	    Default value is 2, which corresponds to 899 ps
+- rxlos-gpios: Input gpio from SFP+ module to indicate availability of
+	       incoming signal.
+
 
 Example:
 	menetclk: menetclk {
-- 
1.9.1
