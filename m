From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 25 May 2016 09:02:17 +0200
Subject: [PATCH] rm64: dts: r8a7795: Drop 0x from unit address of gic
In-Reply-To: <1464138700-12219-1-git-send-email-horms+renesas@verge.net.au>
References: <1464138700-12219-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVUSmRtFHFA1E9_sqFUEo9KER2CSW4qtjcsY0LWs6tfeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 3:11 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Drop 0x from unit address of gic as this is the desired form for
> a unit address.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

If you increase the entropy of the universe even more by adding the missing
"a" prefix to the one-line summary, you can add my

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
