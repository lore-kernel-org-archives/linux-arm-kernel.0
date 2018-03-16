From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 16 Mar 2018 11:01:24 +0100
Subject: [PATCH] arm64: dts: armada-3720-espressobin: Document URL for
 schematic
Message-ID: <20180316100124.29972-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The schematic of hte espressobin is publicly available, add a comment
where to find it.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index bdfb5553ddb5..6d070b267abe 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -42,6 +42,9 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
+/*
+ * Schematic available at http://espressobin.net/wp-content/uploads/2017/08/ESPRESSObin_V5_Schematics.pdf
+ */
 
 /dts-v1/;
 
-- 
2.16.2
