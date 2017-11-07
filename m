From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 11:19:42 +0100
Subject: [PATCH 2/4] arm64: dts: renesas: r8a77970: Tie SYS-DMAC to
 IPMMU-DS1
In-Reply-To: <20171101103504.7658-3-horms+renesas@verge.net.au>
References: <20171101103504.7658-1-horms+renesas@verge.net.au>
 <20171101103504.7658-3-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdU19MGhi8NCpM=8W4zVJga2kO3Vv8syvFeEjjPn09NjZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:35 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hook up r8a77970 DMAC nodes to the IPMMU. In particular
> SYS-DMAC1 and SYS-DMAC2 get tied to IPMMU-DS1.
>
> Based on work for the r8a7796 by Magnus Damm.
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
