From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Feb 2018 19:22:24 +0100
Subject: [PATCH 8/8] arm64: dts: renesas: r8a77965: Add EtherAVB device
 node
In-Reply-To: <1519667836-31330-9-git-send-email-jacopo+renesas@jmondi.org>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519667836-31330-9-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdUXRVwgvN0aZLFGUpFuvrcgcdYqjj-OsBb6vsVH9okq8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

On Mon, Feb 26, 2018 at 6:57 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Populate the ethernet at e6800000 device node to enable Ethernet interface
> for R-Car M3-N (R8A77965) SoC.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> ---
> v1 -> v2:
> - Replace ALWAYS_ON power area identifier with numeric constant

And you added the iommus property, which I wouldn't bother doing at this
early stage.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
