From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Oct 2015 10:33:30 +0100
Subject: [PATCH v4 1/3] arm64: renesas: r8a7795: add I2C support
In-Reply-To: <1445987129-13496-2-git-send-email-horms+renesas@verge.net.au>
References: <1445987129-13496-1-git-send-email-horms+renesas@verge.net.au>
 <1445987129-13496-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWKrr=s5BZb=5VsHunAeOVo8xc-jDicW+XaWF3=Mmvz3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 12:05 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> [geert: aAdd clock-output-names properties]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

As the clock-output-names are no longer valid, please replace the
above two lines by

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
