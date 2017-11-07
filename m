From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 11:05:47 +0100
Subject: [PATCH 5/7] arm64: dts: renesas: r8a7796: Point VSPI via FCPVI to
 IPMMU-VC0
In-Reply-To: <20171101103458.7582-6-horms+renesas@verge.net.au>
References: <20171101103458.7582-1-horms+renesas@verge.net.au>
 <20171101103458.7582-6-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWEkwK=9YgYwKbH5y=9oy7+5dZ2Z3k-+jd0yJzgKshavg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hook up the FCPVI devices to allow use of VSPI with IPMMU-VC0.
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
