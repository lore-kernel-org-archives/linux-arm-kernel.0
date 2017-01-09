From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 9 Jan 2017 20:15:11 +0200
Subject: [PATCH v2 1/4] dmaengine: pl330: remove pdata based initialization
In-Reply-To: <1483970598-6191-2-git-send-email-m.szyprowski@samsung.com>
References: <1483970598-6191-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170109140325eucas1p2674704b2505517ee532284c58c8a64d1@eucas1p2.samsung.com>
 <1483970598-6191-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170109181511.37da3mslzdiq4uhr@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 03:03:15PM +0100, Marek Szyprowski wrote:
> This driver is now used only on platforms which support device tree, so
> it is safe to remove legacy platform data based initialization code.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/dma/pl330.c        | 30 ++++++++----------------------
>  include/linux/amba/pl330.h | 35 -----------------------------------

Nope:
$ git grep pl330.h
arch/arm/plat-samsung/devs.c:#include <linux/amba/pl330.h>

Best regards,
Krzysztof
