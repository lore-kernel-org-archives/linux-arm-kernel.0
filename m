From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 11 May 2016 15:46:07 +0200
Subject: [PATCHv3 0/4] ARM: dts: r8a779[0-4]: Reference both DMA
 controllers
In-Reply-To: <1462972438-20797-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1462972438-20797-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <CAMuHMdWdfJMn+GzEQxpaMW3xYKZQYGK4v_tS_4ZiYjeRNQqGXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

On Wed, May 11, 2016 at 3:13 PM, Niklas S?derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> R-Car Gen2 have two DMA controllers, which are equivalent. However DMA
> slaves were tied only to a single DMA controller in .dtsi. This series
> add references to to both DMA controllers for all nodes that previously
> only referenced one of them. It also adds dma references to the SDHI
> nodes for r8a7794 which according to the datasheet should work but I
> have not access to HW to verify.

Thanks for your series!

> Niklas S?derlund (4):
>   ARM: dts: r8a7790: Reference both DMA controllers
>   ARM: dts: r8a7791: Reference both DMA controllers
>   ARM: dts: r8a7793: Reference both DMA controllers
>   ARM: dts: r8a7794: Reference both DMA controllers

For patches 2-4:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
