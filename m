From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Dec 2016 11:43:58 +0100
Subject: [PATCH renesas/devel 2/4] ARM: dts: r8a7791: Use R-Car Gen 2
 fallback binding for msiof nodes
In-Reply-To: <1482229959-25584-3-git-send-email-horms+renesas@verge.net.au>
References: <1482229959-25584-1-git-send-email-horms+renesas@verge.net.au>
 <1482229959-25584-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXK_AQD4L2mVV7cYzFWV7+BKtcMmXr6FXTZhF6YPdOi9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 11:32 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use recently added R-Car Gen 2 fallback binding for msiof nodes in
> DT for r8a7791 SoC.
>
> This has no run-time effect for the current driver as the initialisation
> sequence is the same for the SoC-specific binding for r8a7791 and the
> fallback binding for R-Car Gen 2.
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
