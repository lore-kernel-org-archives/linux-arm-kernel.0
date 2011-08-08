From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 8 Aug 2011 13:42:45 +0200
Subject: [PATCH] dmaengine: PL08x: Fix trivial build error
In-Reply-To: <E1QpcR1-00013t-Sj@rmk-PC.arm.linux.org.uk>
References: <E1QpcR1-00013t-Sj@rmk-PC.arm.linux.org.uk>
Message-ID: <CAKnu2MoWEcY_fkD7pt1Be9-6TSiZQben3qZv-uoQF3SG-xmyzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/6 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Something changed during the 3.1 merge window in the include files
> which now causes the pl08x DMA engine driver to fail to build. ?Fix
> this by adding the now necessary dma-mapping.h include:
>
> drivers/dma/amba-pl08x.c: In function ?pl08x_unmap_buffers?:
> drivers/dma/amba-pl08x.c:1524: error: implicit declaration of function ?dma_unmap_single?
> drivers/dma/amba-pl08x.c:1527: error: implicit declaration of function ?dma_unmap_page?
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> If you can provide an ack, and I'll push this through my pending
> 'fixes' merge.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
