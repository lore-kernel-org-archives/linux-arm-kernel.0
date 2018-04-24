From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 24 Apr 2018 11:32:08 +0200
Subject: [PATCH] arm64: dts: renesas: r8a7795-es1: Enable IPMMU devices
In-Reply-To: <20180424092659.23657-1-horms+renesas@verge.net.au>
References: <20180424092659.23657-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXyfdt586hzMmL6LP8AOXFuDbtFs1u_vAf-oRj-+MeHog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 11:26 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Remove 'status = "disabled"' to make sure all IPMMU devices are enabled
> in DT on the r8a7795 ES1.0 Soc.
>
> This is a follow up for a patch by Magnus Damm for the
> the r8a7795 ES2.0 and other R-Car Gen 3 SoCs.
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
