From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 Sep 2016 10:19:20 +0200
Subject: [PATCH RFC 6/8] ARM: dts: r8a7743: add SYS-DMAC support
In-Reply-To: <1815255.1arMxK7TDL@wasted.cogentembedded.com>
References: <3533019.Wim1Kuh1ic@wasted.cogentembedded.com>
 <1815255.1arMxK7TDL@wasted.cogentembedded.com>
Message-ID: <CAMuHMdXz5K66AU7d-+NsPrAyc8V53mDxzggiUk-TrFRAwBFXOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 3:36 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> --- renesas.orig/arch/arm/boot/dts/r8a7743.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7743.dtsi
> @@ -90,6 +90,70 @@
>                         #power-domain-cells = <1>;
>                 };
>
> +               dmac0: dma-controller at e6700000 {
> +                       compatible = "renesas,dmac-r8a7743",

To be documented.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
