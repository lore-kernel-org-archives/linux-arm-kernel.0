From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 3 Mar 2016 09:31:49 +0100
Subject: [PATCH] bus: simple-pm-bus: Use ARCH_RENESAS
In-Reply-To: <1456969198-20365-1-git-send-email-horms+renesas@verge.net.au>
References: <1456969198-20365-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVU1RPAafTbUpw6CyW-tQ1amHeiR2DGY_QK8vTFEXpHTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2016 at 2:39 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
