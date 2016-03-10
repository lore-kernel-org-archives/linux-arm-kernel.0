From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 10 Mar 2016 13:09:41 +0100
Subject: [PATCH 29/30] ARM: dts: r8a7794: Reference both DMA controllers
 in SDHI nodes
In-Reply-To: <1457609782-24108-30-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457609782-24108-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1457609782-24108-30-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <CAMuHMdVEQZXc=nqn7w5YbNOWGX8XevSLm0pRbQ5HF5a+dPqYRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 12:36 PM, Niklas S?derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> R-Car Gen2 have two DMA controllers, which are equivalent. Add
> references to both dmac0 and dmac1 so the driver can fallback to the
> later if the first one is unavailable.
>
> Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
