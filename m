From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 2 May 2018 15:10:18 +0200
Subject: [PATCH 00/10] ARM, arm64: dts: renesas: update register properties
In-Reply-To: <20180426102951.8683-1-horms+renesas@verge.net.au>
References: <20180426102951.8683-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUBtNrny+DPqamKSL6nmiyuF38BQdD0eqc7kzDhuMSQqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Apr 26, 2018 at 12:29 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> this series:
>
> 1. Drops unnecessary address properties from VIN port nodes
>    on Renesas R-Car Gen2 SoC board DTSes. These are unnecessary
>    as the nodes to not have bus addresses.

I guess the example in Documentation/devicetree/bindings/media/rcar_vin.txt
should be updated, too?

> 2. And adds address properties to R-Car Sound port nodes on
>    Renesas R-Car Gen2 SoC DTSes. These are necessary as the nodes
>    have unit names.

Documentation/devicetree/bindings/sound/renesas,rsnd.txt doesn't say
anything about the presence of ports?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
