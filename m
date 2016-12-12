From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 12 Dec 2016 14:45:03 +0100
Subject: [PATCH renesas/devel 13/13] ARM: dts: r8a7794: Use R-Car Gen 2
 fallback binding for i2c nodes
In-Reply-To: <1481533902-14789-14-git-send-email-horms+renesas@verge.net.au>
References: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
 <1481533902-14789-14-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWbUqdb1nQSq4kMcVU2p1puG7gAwJZ9kJqniiqhJTYHTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2016 at 10:11 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use recently added R-Car Gen 2 fallback binding for iii nodes in
> DT for r8a7794 SoC.

iic etc...

> This has no run-time effect for the current driver as the initialisation
> sequence is the same for the SoC-specific binding for r8a7794 and the
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
