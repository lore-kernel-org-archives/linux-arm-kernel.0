From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 8 May 2018 20:40:05 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77970: add SMP support
In-Reply-To: <54dbd1d2-8279-5073-cffb-c647fba91e42@cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <54dbd1d2-8279-5073-cffb-c647fba91e42@cogentembedded.com>
Message-ID: <CAMuHMdUqVVWz0jLb2Vmrkk3BQBsYVsCOW1zsaPUi8o6jr_mojQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, May 8, 2018 at 6:39 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the device node for the second Cortex-A53 CPU core.
>
> Based on the original (and large) patch by Daisuke Matsushita
> <daisuke.matsushita.ns@hitachi.com>.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Dupe of https://patchwork.kernel.org/patch/10032875/
>From series "[PATCH 0/2] arm64: dts: renesas: r8a77970: Add SMP Support"
(https://www.spinics.net/lists/linux-renesas-soc/msg19681.html)

> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
> @@ -41,6 +41,16 @@
>                         enable-method = "psci";
>                 };
>
> +               a53_1: cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53","arm,armv8";

Missing space after the comma.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
