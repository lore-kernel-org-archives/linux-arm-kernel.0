From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 12 May 2017 16:39:03 +0200
Subject: [PATCH/RFT renesas-devel] arm64: dts: ulcb: Set drive-strength
 for ravb pins
In-Reply-To: <1493721024-15042-1-git-send-email-horms+renesas@verge.net.au>
References: <1493721024-15042-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWeLAq7nZ7zu2xJ7vG-oM+-TSZm0eY68Cm-9eUREMjhXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, May 2, 2017 at 12:30 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> The EthernetAVB should not depend on the bootloader to setup correct
> drive-strength values.  Values for drive-strength where found by
> examining the registers after the bootloader has configured the
> registers and successfully used the EthernetAVB.
>
> Based on:
> * commit 7d73a4da2681 ("arm64: dts: r8a7795: salvator-x: Set drive-strength
>   for ravb pins")
> * commit 4903987033be ("arm64: dts: r8a7796: salvator-x: Set drive-strength
>   for ravb pins")
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> * Compile tested only due to lack of hardware access

So how did you examine the registers? ;-)

Hence I examined the registers myself:
  - H3ULCB has the same register settings as Salvator-X with H3 ES1.0
  - M3ULCB has the same register settings as Salvator-X with M3-W ES1.0
    or H3 ES2.0.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
