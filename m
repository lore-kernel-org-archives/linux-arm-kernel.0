From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Feb 2014 07:25:50 +0900
Subject: [PATCH 1/3] irqchip: exynos-combiner: call handle_bad_irq directly
In-Reply-To: <52D01D96.8000401@samsung.com>
References: <1389321142-4073-1-git-send-email-pankaj.dubey@samsung.com>
 <52D01D96.8000401@samsung.com>
Message-ID: <52FD466E.9060304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/14 01:19, Tomasz Figa wrote:
> Hi Pankaj,
>
> On 10.01.2014 03:32, Pankaj Dubey wrote:
>> This patch is inspired from following commit
>> aec0095653: (irqchip: gic: Call handle_bad_irq() directly)
>>
>> Also this will help in removing unwanted inclusion
>> of header file "asm/mach/irq.h"
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>> drivers/irqchip/exynos-combiner.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>
Applied, thanks.

- Kukjin
