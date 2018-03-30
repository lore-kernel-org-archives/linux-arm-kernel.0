From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 30 Mar 2018 11:28:06 +0200
Subject: [PATCH] ARM: debug-ll: Add support for r8a77470
In-Reply-To: <1522320146-41110-1-git-send-email-biju.das@bp.renesas.com>
References: <1522320146-41110-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <CAMuHMdWJLrkLndVazM5QSE938sJ0kDphzodPcMc2t8T4_=9oUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2018 at 12:42 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> Enable low-level debugging support for RZ/G1C (r8a77470). RZ/G1C uses
> SCIF1 for the debug console.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
