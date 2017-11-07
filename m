From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 10:20:40 +0100
Subject: [PATCH v4 05/15] arm64: dts: renesas: r8a7795: Point DU/VSPD via
 FCPVD to IPMMU-VI0/1
In-Reply-To: <20171101103452.7491-6-horms+renesas@verge.net.au>
References: <20171101103452.7491-1-horms+renesas@verge.net.au>
 <20171101103452.7491-6-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWq4PCpVPoQb=jA9sbpJcnowDcfEM61bW6tijMoYdu5xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Hook up the FCPVD devices to allow use of the VSP and DU
> together with IPMMU-VI1 and IPMMU-VI1.
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
