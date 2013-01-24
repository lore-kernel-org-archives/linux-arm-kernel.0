From: Frank.Li@freescale.com (Frank Li)
Date: Thu, 24 Jan 2013 15:06:59 +0800
Subject: [PATCH 2/2 net-next] doc: dt: fsl: fec: add napi optional properties
Message-ID: <1359011219-8343-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 Documentation/devicetree/bindings/net/fsl-fec.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
index d536392..4a94090 100644
--- a/Documentation/devicetree/bindings/net/fsl-fec.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
@@ -15,6 +15,8 @@ Optional properties:
   only if property "phy-reset-gpios" is available.  Missing the property
   will have the duration be 1 millisecond.  Numbers greater than 1000 are
   invalid and 1 millisecond will be used instead.
+- disable_napi : disable napi support
+- napi_weight : napi weight number, default value is 64
 
 Example:
 
-- 
1.7.1
