From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Fri, 30 Dec 2016 16:56:43 +0800
Subject: [PATCH v5 02/14] irqchip: gic-v3-its: keep the head file include
 in alphabetic order
In-Reply-To: <1482384922-21507-3-git-send-email-guohanjun@huawei.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-3-git-send-email-guohanjun@huawei.com>
Message-ID: <5866214B.8090803@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> The head file is strictly in alphabetic order now, so let's
> be the rule breaker. As acpi_iort.h includes acpi.h so remove
> the duplidate acpi.h inclusion as well.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 69b040f..f471939 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -15,14 +15,13 @@
>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> -#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
>   #include <linux/bitmap.h>
>   #include <linux/cpu.h>
>   #include <linux/delay.h>
>   #include <linux/dma-iommu.h>
>   #include <linux/interrupt.h>
>   #include <linux/irqdomain.h>
> -#include <linux/acpi_iort.h>
>   #include <linux/log2.h>
>   #include <linux/mm.h>
>   #include <linux/msi.h>
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>
