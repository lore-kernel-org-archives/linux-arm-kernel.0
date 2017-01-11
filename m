From: mbrugger@suse.com (Matthias Brugger)
Date: Wed, 11 Jan 2017 11:20:41 +0100
Subject: [PATCH v6 02/14] irqchip: gic-v3-its: keep the head file include
 in alphabetic order
In-Reply-To: <1483363905-2806-3-git-send-email-hanjun.guo@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <ef759a3a-bbdb-2586-24a8-6ad650b07d41@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/01/17 14:31, Hanjun Guo wrote:
> The head file is strictly in alphabetic order now, so let's
> be the rule breaker. As acpi_iort.h includes acpi.h so remove
> the duplidate acpi.h inclusion as well.
>

Sounds strange, maybe someting like:
Rearrange header file includes to alphabetic order. As acpi_iort.h...

Regards,
Matthias

> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Majun <majun258@huawei.com>
> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 69b040f..f471939 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -15,14 +15,13 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> -#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
>  #include <linux/bitmap.h>
>  #include <linux/cpu.h>
>  #include <linux/delay.h>
>  #include <linux/dma-iommu.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqdomain.h>
> -#include <linux/acpi_iort.h>
>  #include <linux/log2.h>
>  #include <linux/mm.h>
>  #include <linux/msi.h>
>
