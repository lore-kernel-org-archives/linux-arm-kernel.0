From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 18 Oct 2017 09:36:56 +0200
Subject: [PATCH 5/7] ARM: dts: r8a7791: Use R-Car Gen2 Ether fallback
 compat string
In-Reply-To: <20171018072728.14681-6-horms+renesas@verge.net.au>
References: <20171018072728.14681-1-horms+renesas@verge.net.au>
 <20171018072728.14681-6-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUTUy61UvujB9XnUus5N2zcfsyNsbyUOPt8-v8c+ZukQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 9:27 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use newly added R-Car Gen2 Ether fallback compat string
> in the DT of the r8a7791 SoC.
>
> This should have no run-time effect as the driver matches against
> the per-SoC compat string before considering the fallback compat string.
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
