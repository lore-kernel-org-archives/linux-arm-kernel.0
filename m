From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 23 Apr 2014 09:09:49 +0200
Subject: [PATCH 22/33] ARM: shmobile: Use r8a7740 suffix for i2c, mmcif,
 fsi2 compat strings
In-Reply-To: <5c53f50c50badff499568a703467c3c9f23f9bfd.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
 <5c53f50c50badff499568a703467c3c9f23f9bfd.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUA+wJmgn0P_q38ri7_TAq7zha-ekSUrvdpntG5gFv56Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 3:25 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Ulrich Hecht <ulrich.hecht@gmail.com>
>
> Add "renesas,*-r8a7740" to the compatible strings for consistency with other
> devices.

> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index 8280884..9f65986 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -126,7 +126,7 @@

> -               compatible = "renesas,rmobile-iic";
> +               compatible = "renesas,iic-r8a7740", "renesas,rmobile-iic";

I see an opportunity for improvement here: this driver doesn't seem to have
any bindings documented under Documentation/devicetree/bindings/?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
