From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 10:31:32 +0100
Subject: [PATCH v4 09/15] arm64: dts: renesas: r8a7795: Point VSPBC/VSPBD
 via FCPVB to IPMMU-VP0/1
In-Reply-To: <20171101103452.7491-10-horms+renesas@verge.net.au>
References: <20171101103452.7491-1-horms+renesas@verge.net.au>
 <20171101103452.7491-10-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUi39-yLKTJ=V9tDf9=B7qhWh0Vm8uhm2LYXzzbK4_Tew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Hook up the FCPVB devices to allow use of VSPBC/VSPBD with
> IPMMU-VP0 and IPMMU-VP1.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
