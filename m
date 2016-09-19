From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 Sep 2016 09:53:37 +0200
Subject: [PATCH RFC 4/8] ARM: shmobile: r8a7743: basic SoC support
In-Reply-To: <7093322.WFIWVqz40g@wasted.cogentembedded.com>
References: <3533019.Wim1Kuh1ic@wasted.cogentembedded.com>
 <7093322.WFIWVqz40g@wasted.cogentembedded.com>
Message-ID: <CAMuHMdU8snWdKzsBoqjvP7PrBBcMychTcsdMSJC5ptrs_Pt82A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Sep 16, 2016 at 3:33 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add minimal support for the RZ/G1M (R8A7743) SoC.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- /dev/null
> +++ renesas/arch/arm/mach-shmobile/setup-r8a7743.c
> @@ -0,0 +1,34 @@

> +static const char * const r8a7743_boards_compat_dt[] __initconst = {
> +       "renesas,r8a7743",

To be documented in
Documentation/devicetree/bindings/arm/shmobile.txt.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
