From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 10 Jan 2014 17:19:34 +0100
Subject: [PATCH 1/3] irqchip: exynos-combiner: call handle_bad_irq directly
In-Reply-To: <1389321142-4073-1-git-send-email-pankaj.dubey@samsung.com>
References: <1389321142-4073-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <52D01D96.8000401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 10.01.2014 03:32, Pankaj Dubey wrote:
> This patch is inspired from following commit
>   aec0095653: (irqchip: gic: Call handle_bad_irq() directly)
>
> Also this will help in removing unwanted inclusion
> of header file "asm/mach/irq.h"
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>   drivers/irqchip/exynos-combiner.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
