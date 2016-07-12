From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 12 Jul 2016 15:46:16 +0800
Subject: [PATCH V2 07/15] doc: dt: fsl-imx-esdhc: add set tuning start point
 binding
In-Reply-To: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1468309584-3591-8-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add tuning start point binding

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index dca56d6248f5..3e29050ec769 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -28,6 +28,8 @@ Optional properties:
   transparent level shifters on the outputs of the controller. Two cells are
   required, first cell specifies minimum slot voltage (mV), second cell
   specifies maximum slot voltage (mV). Several ranges could be specified.
+- fsl,tuning-start-tap: Specify the start dealy cell point when send first CMD19
+  in tuning procedure.
 - fsl,tuning-step: Specify the increasing delay cell steps in tuning procedure.
   The uSDHC use one delay cell as default increasing step to do tuning process.
   This property allows user to change the tuning step to more than one delay
-- 
1.9.1
