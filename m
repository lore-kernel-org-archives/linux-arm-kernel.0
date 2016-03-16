From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 16 Mar 2016 09:56:24 +0100
Subject: [PATCH] ARM: dts: lager: use generic pinctrl properties
In-Reply-To: <1458090189-25803-1-git-send-email-horms+renesas@verge.net.au>
References: <1458090189-25803-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWqTCTF-Oy8iGME8JZsjt+GJMN87_XEH3Uhtxa-ymH2KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 2:03 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
> groups properties") renesas pfc drivers accept generic "function", "pins"
> and "groups" properties.
>
> This patch updates the lager device tree to use the generic
> rather than renesas-specific properties.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
