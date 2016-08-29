From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 Aug 2016 15:34:57 +0200
Subject: [PATCH] ARM: dts: rskrza1: initial device tree
In-Reply-To: <20160825153115.15291-1-chris.brandt@renesas.com>
References: <20160825153115.15291-1-chris.brandt@renesas.com>
Message-ID: <CAMuHMdXmJPcgDcLkeVuF5YVfpwxRkJpACHGwtbNab18gK-nBbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Thu, Aug 25, 2016 at 5:31 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> Add the initial device tree for the RZ/A1 based development board (RSK).

Thanks for your patch!

> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- /dev/null
> +++ b/arch/arm/boot/dts/r7s72100-rskrza1.dts

> +       compatible = "renesas,rskrza1", "renesas,r7s72100";

scripts/checkpatch.pl says:

    DT compatible string "renesas,rskrza1" appears un-documented --
check ./Documentation/devicetree/bindings/

Please send a follow-up patch to add this compatible value to
Documentation/devicetree/bindings/arm/shmobile.txt.

> +&scif2 {
> +       status = "okay";
> +};
> +

Please drop the trailing empty line.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
