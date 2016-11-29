From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 29 Nov 2016 21:39:30 +0800
Subject: [PATCH v4 02/11] irqchip: gic-v3-its: keep the head file include in
 alphabetic order
In-Reply-To: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
References: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1480426779-31387-3-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

The head file is strictly in alphabetic order now, so let's
be the rule breaker. As acpi_iort.h includes acpi.h so remove
the duplidate acpi.h inclusion as well.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c5dee30..1508bf4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -15,14 +15,13 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
-#include <linux/acpi_iort.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
-- 
1.7.12.4
