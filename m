From: jagan@openedev.com (Jagan Teki)
Date: Fri, 23 Dec 2016 17:02:15 +0100
Subject: [PATCH 2/2] ARM: dts: imx6q-icore-rqs: Update model to support Dual
 SOM
In-Reply-To: <1482508935-9414-1-git-send-email-jagan@openedev.com>
References: <1482508935-9414-1-git-send-email-jagan@openedev.com>
Message-ID: <1482508935-9414-2-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Engicam i.CoreM6 Dual and Quad SOM's use same dts file, hence
update model name to add Dual and also added full mode decsription.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6q-icore-rqs.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-icore-rqs.dts b/arch/arm/boot/dts/imx6q-icore-rqs.dts
index 0053188..76757f8 100644
--- a/arch/arm/boot/dts/imx6q-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6q-icore-rqs.dts
@@ -45,7 +45,7 @@
 #include "imx6qdl-icore-rqs.dtsi"
 
 / {
-	model = "Engicam i.CoreM6 Quad SOM";
+	model = "Engicam i.CoreM6 Quad/Dual RQS Starter Kit";
 	compatible = "engicam,imx6-icore-rqs", "fsl,imx6q";
 
 	sound {
-- 
1.9.1
