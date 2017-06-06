From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 6 Jun 2017 09:41:16 +0200
Subject: [PATCH 2/4] ARM: shmobile: document iW-RainboW-G20D-Qseven-RZG1M
 board
In-Reply-To: <1496420523-23506-3-git-send-email-biju.das@bp.renesas.com>
References: <1496420523-23506-1-git-send-email-biju.das@bp.renesas.com>
 <1496420523-23506-3-git-send-email-biju.das@bp.renesas.com>
Message-ID: <CAMuHMdUHetaZMhfxBXF-1y0yv5UdUQrxH7NpkUfymty5hs_7EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Biju,

On Fri, Jun 2, 2017 at 6:22 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> Document the iW-RainboW-G20D-Qseven-RZG1M device tree bindings,
> listing it as a supported board.
>
> This allows to use checkpatch.pl to validate .dts files referring to the
> iW-RainboW-G20D-Qseven-RZG1M board.

Thanks for your patch!

> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -69,6 +69,8 @@ Boards:
>      compatible = "renesas,kzm9d", "renesas,emev2"
>    - Kyoto Microcomputer Co. KZM-A9-GT
>      compatible = "renesas,kzm9g", "renesas,sh73a0"
> +  - iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
> +    compatible = "iwave,g20d", "renesas,r8a7743"

Please keep the list sorted alphabetically.

>    - Lager (RTP0RC7790SEB00010S)
>      compatible = "renesas,lager", "renesas,r8a7790"
>    - M3ULCB (R-Car Starter Kit Pro, RTP0RC7796SKB00010S)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
