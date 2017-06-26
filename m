From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Jun 2017 10:13:00 +0200
Subject: [PATCH v2] gpio: rcar: Add R8A7743 (RZ/G1M) support
In-Reply-To: <1498055229-42052-1-git-send-email-biju.das@bp.renesas.com>
References: <1497619944-61410-1-git-send-email-biju.das@bp.renesas.com>
 <1498055229-42052-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <CAMuHMdVW6gU8GTf5v6xq0sYMgYqCaOaHcu1Ap1FDw14bUJih+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 4:27 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> Renesas RZ/G1M (R8A7743) SoC GPIO blocks are identical to the R-Car Gen2
> family. Add support for its GPIO controllers.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Although I think the time has come for family-specific compatible values
for R-Car Gen2 and Gen3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
