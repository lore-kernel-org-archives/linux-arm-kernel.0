From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Thu, 15 Oct 2015 12:17:46 +0530
Subject: [PATCH v3 06/12] doc/bindings: Update GPIO devicetree binding
 documentation for LS2080A
In-Reply-To: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1444891672-32117-7-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the FSL, GPIO binding documentation to add support
for GPIO controller found on Freescale's LS2080A platform.

Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 .../devicetree/bindings/gpio/gpio-mpc8xxx.txt      |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
index 805ddcd..f2455c5 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
@@ -1,9 +1,9 @@
-* Freescale MPC512x/MPC8xxx GPIO controller
+* Freescale MPC512x/MPC8xxx/Layerscape GPIO controller
 
 Required properties:
 - compatible : Should be "fsl,<soc>-gpio"
   The following <soc>s are known to be supported:
-    mpc5121, mpc5125, mpc8349, mpc8572, mpc8610, pq3, qoriq
+    mpc5121, mpc5125, mpc8349, mpc8572, mpc8610, pq3, qoriq.
 - reg : Address and length of the register set for the device
 - interrupts : Should be the port interrupt shared by all 32 pins.
 - #gpio-cells : Should be two.  The first cell is the pin number and
-- 
1.7.9.5
