From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 Dec 2017 09:43:06 +0100
Subject: [PATCH v2 1/2] ARM: dts: r8a7743: sort root sub-nodes
 alphabetically
In-Reply-To: <20171218214043.10796-2-horms+renesas@verge.net.au>
References: <20171218214043.10796-1-horms+renesas@verge.net.au>
 <20171218214043.10796-2-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVNCyW=QU08eg=1j8Xyq1wBhsY6KxmpjCLi8X7mZD8YCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Dec 18, 2017 at 10:40 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Sort root sub-nodes alphabetically for allow for easier maintenance

to allow for

> of this file.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/boot/dts/r8a7743.dtsi
> +++ b/arch/arm/boot/dts/r8a7743.dtsi

>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> @@ -79,6 +102,37 @@
>                 };
>         };
>
> +       /* External CAN clock */
> +       can_clk: can {

Doesn't look alphabetically to me...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
