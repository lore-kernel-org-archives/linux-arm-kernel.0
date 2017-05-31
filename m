From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 31 May 2017 13:58:51 +0300
Subject: [PATCH 09/10] staging: fsl-mc: add reference to mc-bus DT binding
In-Reply-To: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
References: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
Message-ID: <20170531105852.22304-10-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Update README to reference the mc-bus device tree node
binding.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---

Notes:
  -no changes

 drivers/staging/fsl-mc/README.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/fsl-mc/README.txt b/drivers/staging/fsl-mc/README.txt
index d7cd70a..524eda1 100644
--- a/drivers/staging/fsl-mc/README.txt
+++ b/drivers/staging/fsl-mc/README.txt
@@ -320,6 +320,8 @@ A brief description of each driver is provided below.
        -creates an MSI IRQ domain
        -doing a 'device add' to expose the 'root' DPRC, in turn triggering
         a bind of the root DPRC to the DPRC driver
+    The binding for the MC-bus device-tree node can be consulted here:
+        Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 
     DPRC driver
     -----------
-- 
2.9.4
