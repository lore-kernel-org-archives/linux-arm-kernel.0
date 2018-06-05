From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 5 Jun 2018 15:24:55 +0200
Subject: [PATCH v4 3/3] ARM: dts: Renesas R9A06G032 SMP enable method
In-Reply-To: <1528198148-23308-4-git-send-email-michel.pollet@bp.renesas.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-4-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <CAMuHMdU1n0tQgPaEXAn6W1aVCDBjk-h0Mz2kgh2vu4e9CEi0XQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 5, 2018 at 1:28 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> Add a special enable method for the second CA7 of the R9A06G032
> as well as the default value for the "cpu-release-addr" property.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -1,3 +1,4 @@
> +

Bogus change

>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Base Device Tree Source for the Renesas RZ/N1D (R9A06G032)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
