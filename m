From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Feb 2018 10:23:13 +0100
Subject: [PATCH 2/6] arm64: dts: renesas: r8a77965: Add #address-cells and
 #size-cells
In-Reply-To: <1519326370-15805-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519326370-15805-3-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdXW2JZr1=XTqdxc1s9_woH=Sget8m3aM6FMXFF4JYoeeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add "#address-cells" and "#size-cells" properties to all place-holder nodes
> that have children nodes defined by salvator-x[s].dtsi device tree.
>
> This silences the following DTC compiler warnings:
> Warning (reg_format): "reg" property in /soc/.. has invalid length (4 bytes)
> (#address-cells == 2, #size-cells == 1)
> Warning (avoid_default_addr_size): Relying on default #address-cells
> value for /soc/...
> Warning (avoid_default_addr_size): Relying on default #size-cells value
> for /soc/...
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
