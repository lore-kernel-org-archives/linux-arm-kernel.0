From: qiang.zhao@nxp.com (Zhao Qiang)
Date: Wed, 28 Sep 2016 11:40:38 +0800
Subject: [PATCH 3/3] bindings: add compatible "fsl,
 ls1043-ucc-hdlc" to bindings
In-Reply-To: <1475034038-7217-1-git-send-email-qiang.zhao@nxp.com>
References: <1475034038-7217-1-git-send-email-qiang.zhao@nxp.com>
Message-ID: <1475034038-7217-3-git-send-email-qiang.zhao@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
index 03c7416..325e3e2 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
@@ -45,7 +45,7 @@ Example:
 * HDLC
 
 Currently defined compatibles:
-- fsl,ucc-hdlc
+- "fsl,ucc-hdlc", "fsl,ls1043-ucc-hdlc"
 
 Properties for fsl,ucc-hdlc:
 - rx-clock-name
-- 
2.1.0.27.g96db324
