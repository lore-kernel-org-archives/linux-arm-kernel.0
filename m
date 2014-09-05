From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 5 Sep 2014 13:47:08 +0200
Subject: [PATCH v7 1/5] Documentation: Add device tree bindings for
 Freescale i.MX GPC
In-Reply-To: <1409060791-23167-2-git-send-email-p.zabel@pengutronix.de>
References: <1409060791-23167-1-git-send-email-p.zabel@pengutronix.de>
 <1409060791-23167-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAMuHMdUqbk+OZiBMUsebQ_==7jCan+dHsfJLhi+CPUE=xc6yRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Tue, Aug 26, 2014 at 3:46 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> @@ -0,0 +1,54 @@

> +IP cores belonging to a power domain should contain a 'power-domain' property

power-domains

> +that is a phandle pointing to the gpc device node and a DOMAIN_INDEX specifying
> +the power domain the device belongs to.
> +
> +Example of a device that is part of the PU power domain:
> +
> +       vpu: vpu at 02040000 {
> +               reg = <0x02040000 0x3c000>;
> +               /* ... */
> +               power-domain = <&gpc 1>;

power-domains

> +               /* ... */
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
