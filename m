From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 Aug 2017 15:57:59 +0200
Subject: [PATCH v2 1/3] ARM: dts: r8a7790: Use R-Car SATA Gen2 fallback
 compat string
In-Reply-To: <1502267203-12229-2-git-send-email-horms+renesas@verge.net.au>
References: <1502267203-12229-1-git-send-email-horms+renesas@verge.net.au>
 <1502267203-12229-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXYXU_ox_8d1jC+jgbwupzFWuxDtVSATWSyMxYVZz6kLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 9, 2017 at 10:26 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use newly added R-Car SATA Gen2 fallback compat string
> in the DT of the r8a7790 SoC.
>
> This should have no run-time effect as the driver matches against
> the per-SoC compat string before the fallback compat string is considered.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
