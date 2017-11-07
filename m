From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 11:06:09 +0100
Subject: [PATCH 6/7] arm64: dts: renesas: r8a7796: Connect Ethernet-AVB to
 IPMMU-DS0
In-Reply-To: <20171101103458.7582-7-horms+renesas@verge.net.au>
References: <20171101103458.7582-1-horms+renesas@verge.net.au>
 <20171101103458.7582-7-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdU+jqPUKynofovSZionWCaj0RD9GkoJsX24Lp-zbAre_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add IPMMU-DS0 to the Ethernet-AVB device node.
>
> Based on work by Magnus Damm for the r8a7795.
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
