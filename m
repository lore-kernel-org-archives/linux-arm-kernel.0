From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  8 Jul 2016 18:05:42 +0200
Subject: [PATCH 01/15] ARM: dts: sunxi: Rename sunxi-q8-common.dtsi
 sunxi-reference-design-tablet.dtsi
In-Reply-To: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467993956-19535-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename sunxi-q8-common.dtsi to sunxi-reference-design-tablet.dtsi. This
is part of renaming all the sun?i-q8-common.dtsi files to
sun?i-reference-design-tablet.dtsi since most of the hw-config in there
is shared by all sunxi tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-q8-common.dtsi                                  | 2 +-
 arch/arm/boot/dts/sun8i-q8-common.dtsi                                  | 2 +-
 .../dts/{sunxi-q8-common.dtsi => sunxi-reference-design-tablet.dtsi}    | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{sunxi-q8-common.dtsi => sunxi-reference-design-tablet.dtsi} (100%)

diff --git a/arch/arm/boot/dts/sun5i-q8-common.dtsi b/arch/arm/boot/dts/sun5i-q8-common.dtsi
index a5de28d..8977fb2 100644
--- a/arch/arm/boot/dts/sun5i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun5i-q8-common.dtsi
@@ -39,7 +39,7 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "sunxi-q8-common.dtsi"
+#include "sunxi-reference-design-tablet.dtsi"
 
 #include <dt-bindings/pwm/pwm.h>
 
diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
index f3f4ce0..0b85ea4 100644
--- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
@@ -39,7 +39,7 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "sunxi-q8-common.dtsi"
+#include "sunxi-reference-design-tablet.dtsi"
 
 #include <dt-bindings/pwm/pwm.h>
 
diff --git a/arch/arm/boot/dts/sunxi-q8-common.dtsi b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
similarity index 100%
rename from arch/arm/boot/dts/sunxi-q8-common.dtsi
rename to arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
-- 
2.7.4
