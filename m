From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Dec 2011 23:49:02 +0100
Subject: [PATCH 1/2] DMA: PL330: Merge PL330 driver into drivers/dma/
In-Reply-To: <002901ccb582$ba7e0a20$2f7a1e60$%kim@samsung.com>
References: <002901ccb582$ba7e0a20$2f7a1e60$%kim@samsung.com>
Message-ID: <CACRpkdZZvbJaJ7O7V64msXR5GKHAJ4KCo-cezybVpsaGQa-b6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 8, 2011 at 9:23 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:

> From: Boojin Kim <boojin.kim@samsung.com>
>
> Currently there were two part of DMAC PL330 driver for
> support old styled s3c-pl330 which has been merged into
> drivers/dma/pl330.c driver. Actually, there is no reason
> to separate them now.
>
> Basically this patch merges arch/arm/common/pl330.c into
> drivers/dma/pl330.c driver and removes useless exported
> symbol, externed function and so on.
>
> The newer pl330 driver tested on SMDKV310 and SMDK4212 boards
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Looks good to me,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
