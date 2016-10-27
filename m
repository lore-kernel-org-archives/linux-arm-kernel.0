From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 27 Oct 2016 09:06:57 +0200
Subject: [PATCH] ARM: shmobile: select errata 798181 for SoCs with CA15
 cores
In-Reply-To: <1477551606-6903-1-git-send-email-horms+renesas@verge.net.au>
References: <1477551606-6903-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdX=XtQ1VQfGcY6CyMTGpSzdw_=39vUsqwTgk900fRtMyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 9:00 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Select ARM errata 798181 on SoCs cores affected CA15 cores.

... cores with ...

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
