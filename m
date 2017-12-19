From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 Dec 2017 12:25:02 +0100
Subject: [PATCH v2 3/6] ARM: dts: r8a7743: Add PWM SoC support
In-Reply-To: <1513619528-12060-4-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1513619528-12060-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513619528-12060-4-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdVEgBq+eZqAeas3kf3ARHegSQK9xyVrTDHRyctyTK87QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 6:52 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Add the definitions for pwm[0123456] to the SoC .dtsi.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/boot/dts/r8a7743.dtsi
> +++ b/arch/arm/boot/dts/r8a7743.dtsi
> @@ -1082,6 +1082,83 @@
>                         status = "disabled";
>                 };
>
> +               pwm0: pwm at e6e30000 {
> +                       compatible = "renesas,pwm-r8a7743",
> +                                    "renesas,pwm-rcar";

I think the above can fit in one line.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
