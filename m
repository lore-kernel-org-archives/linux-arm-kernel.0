From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Oct 2017 14:08:51 +0200
Subject: [PATCH] ARM: dts: iwg20d-q7: Add support for ttySC3
In-Reply-To: <1507539981-4193-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1507539981-4193-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdUprE7QuXF_sX47JyrvuZXhXnQFufy4OHeJ5ExwwoogKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio, Chris,

On Mon, Oct 9, 2017 at 11:06 AM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
> +++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
> @@ -11,6 +11,7 @@
>  / {
>         aliases {
>                 serial0 = &scif0;
> +               serial3 = &scifb1;

Given this port is not labeled "serial3", but called "data uart", you may want
to add a comment to avoid confusion:

    serial3 = &scifb1; /* data uart */

>                 ethernet0 = &avb;
>         };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
