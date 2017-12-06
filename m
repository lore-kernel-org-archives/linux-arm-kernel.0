From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 6 Dec 2017 13:12:02 +0100
Subject: [PATCH v2] ARM: dts: r8a7745: Add APMU node and second CPU core
In-Reply-To: <1512561929-16540-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1512561929-16540-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdWTepYLpySfo6hq10-9TrGh+o=P9k5RnTYxBTe-eh-pQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 1:05 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
>
> Add DT node for the Advanced Power Management Unit (APMU), add the
> second CPU core, and use "renesas,apmu" as "enable-method".
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

> v2:
> - rebased against renesas-devel-20171205-v4.15-rc2

Seems my
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
was not added.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
