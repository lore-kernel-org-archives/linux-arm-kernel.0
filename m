From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 14 Sep 2018 14:15:01 +0200
Subject: [RFC PATCH 1/3] ARM: dma-mapping: update comment about handling
 dma_ops when detaching from IOMMU
In-Reply-To: <20180913151716.6333-2-wsa+renesas@sang-engineering.com>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
 <20180913151716.6333-2-wsa+renesas@sang-engineering.com>
Message-ID: <CAMuHMdV_xpj62BkqwoTAaaugM3BkDRQTC=E0cEDqKBg3sUYNBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 5:18 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Update the comment because we don't set the pointer to NULL anymore.
> Also use the correct pointer name 'dma_ops' instead of 'dma_map_ops'.
>
> Fixes: 1874619a7df4 ("ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Nice catch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
