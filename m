From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 26 Jan 2018 11:39:57 +0100
Subject: [PATCH 1/2] ARM: dts: r8a7743: sort subnodes of soc node
In-Reply-To: <20180126094052.17119-2-horms+renesas@verge.net.au>
References: <20180126094052.17119-1-horms+renesas@verge.net.au>
 <20180126094052.17119-2-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXyNDKoq1feunubxG93Qbb0DBYzTU+Xya1O+1b2oBiKig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 10:40 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Sort the subnodes of the soc node to improve maintainability.
> The sort key is the address on the bus with instances of the same
> IP block grouped together and sorted alphabetically.
>
> Minor whitespace and line-wrapping changes are also made
> to match the formatting of R-Car Gen2 SoCs.
>
> This patch should not introduce any functional change.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
using dtx_diff

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
