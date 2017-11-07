From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 11:01:59 +0100
Subject: [PATCH 3/7] arm64: dts: renesas: r8a7796: Tie Audio-DMAC to
 IPMMU-MP
In-Reply-To: <20171101103458.7582-4-horms+renesas@verge.net.au>
References: <20171101103458.7582-1-horms+renesas@verge.net.au>
 <20171101103458.7582-4-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdU1JtdJS87DcSuhx5COAZiJp58=9G2zQaFwfp+howRA0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hook up r8a7796 Audio-DMAC nodes to the IPMMU-MP.
>
> Based on work for the r8a7795 by Magnus Damm.
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
