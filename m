From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 18 Mar 2016 11:59:25 +0100
Subject: [PATCH 00/12] ARM, arm64: dts: use generic pinctrl properties
In-Reply-To: <1458259162-15706-1-git-send-email-horms+renesas@verge.net.au>
References: <1458259162-15706-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVpAg8ixL_x94qBS1tkKWjSXdYuvo4EcD7YVU1sZQ4E8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Mar 18, 2016 at 12:59 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
> groups properties") renesas pfc drivers accept generic "function", "pins"
> and "groups" properties.
>
> This series updates the device trees for the boards of Renesas ARM based
> SoCs to use the generic properties. The device tree for the lager board was
> already updated in an earlier patch which is present in
> renesas-devel-20160318-v4.5.
>
> Based on renesas-devel-20160318-v4.5

Thanks!

For the whole series:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Doh, now I have to update all my DT overlays, as you cannot mix new-style
and old-style properties ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
