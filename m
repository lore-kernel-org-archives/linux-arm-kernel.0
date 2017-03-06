From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue,  7 Mar 2017 01:17:45 +0800
Subject: [PATCH v8 1/6] ARM: dts: sun8i: h3: drop skeleton.dtsi inclusion in
 H3 DTSI
In-Reply-To: <20170306171750.7491-1-icenowy@aosc.xyz>
References: <20170306171750.7491-1-icenowy@aosc.xyz>
Message-ID: <20170306171750.7491-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The skeleton.dtsi file is now deprecated, and do not exist in ARM64
environment.

Since we will soon reuse most part of H3 DTSI for H5, which is an ARM64
chip, drop skeleton.dtsi inclusion now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v8:
- Add h3: in commit message.

 arch/arm/boot/dts/sun8i-h3.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 27780b97c863..9a3435527fde 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -40,8 +40,6 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/clock/sun8i-h3-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
-- 
2.11.1
