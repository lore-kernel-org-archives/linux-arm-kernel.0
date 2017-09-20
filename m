From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 20 Sep 2017 13:10:00 +0200
Subject: [PATCH 8/8] ARM: drs: iwg22m: Add SPI NOR support
In-Reply-To: <1505322341-9480-9-git-send-email-chris.paterson2@renesas.com>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-9-git-send-email-chris.paterson2@renesas.com>
Message-ID: <CAMuHMdW2_Tz6Mu7bwTXiAuyyeUvJTFrbyMAnxCi+Nj7ig65Ong@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 13, 2017 at 7:05 PM, Chris Paterson
<chris.paterson2@renesas.com> wrote:
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>
> Add support for the SPI NOR device used to boot up the system
> to the System on Module DT.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

With the subject fixed (s/drs/dts/):
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
