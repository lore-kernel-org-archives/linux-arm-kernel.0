From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Mar 2018 15:07:18 +0200
Subject: [PATCH 10/12] ARM: dts: iwg23s-sbc: Add support for iWave
 G23S-SBC based on RZ/G1C
In-Reply-To: <1522161443-54428-11-git-send-email-biju.das@bp.renesas.com>
References: <1522161443-54428-1-git-send-email-biju.das@bp.renesas.com>
 <1522161443-54428-11-git-send-email-biju.das@bp.renesas.com>
Message-ID: <CAMuHMdUWB8=hByJsoZhT1=7QncFexKgZQFiNaUPZrkzGgB-=tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Biju,

On Tue, Mar 27, 2018 at 4:37 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> Add support for iWave iW-RainboW-G23S single board computer based on
>  RZ/G1C.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One question below.

> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the iWave-RZ/G1C single board computer
> + *
> + * Copyright (C) 2018 Renesas Electronics Corp.
> + */
> +
> +/dts-v1/;
> +#include "r8a77470.dtsi"
> +/ {
> +       model = "iWave iW-RainboW-G23S single board computer based on RZ/G1C";
> +       compatible = "iwave,g23s", "renesas,r8a77470";
> +
> +       aliases {
> +               serial1 = &scif1;
> +       };

No chosen / stdout-path?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
