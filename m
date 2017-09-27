From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 27 Sep 2017 14:02:53 +0200
Subject: [PATCH] ARM: dts: r8a7743: Add MSIOF[012] support
In-Reply-To: <1506506225-5015-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1506506225-5015-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdXMC0iYa0nB3nd4zkKAMBHppeLq+HPVu6cH-vrXwD1wew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 11:57 AM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Add the DT nodes needed by MSIOF[012] interfaces to the SoC dtsi.
> Also, define aliases for spi[123].
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
