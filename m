From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 11:13:36 +0100
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77995: Add IPMMU device nodes
In-Reply-To: <20171101103508.7721-2-horms+renesas@verge.net.au>
References: <20171101103508.7721-1-horms+renesas@verge.net.au>
 <20171101103508.7721-2-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVS_5_iouNei_HvgUtWTVS_NuLcbpua_K_VUQqr7Pt_QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:35 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add r8a77995 IPMMU nodes and keep all disabled by default.
>
> Based on work for the r8a7795 and r8a7796 by Magnus Damm
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

My comment for r8a7795.dtsi about IPMMU-* comments is applicable here, too.
My comment about power-domains properties probably isn't, as R-Car D3
doesn't have I/O power domains, which table 16.2 doesn't take into account.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
