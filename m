From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 18 Aug 2017 10:24:27 +0200
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.14
In-Reply-To: <cover.1502961153.git.horms+renesas@verge.net.au>
References: <cover.1502961153.git.horms+renesas@verge.net.au>
Message-ID: <CAMuHMdX5kH6n0hxfdNMQai+a+rVhpyKppZ1U+vVR8COwBtjoOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Aug 18, 2017 at 10:19 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> * Add PFC device node to R-Car D3 (r8a77995)
>
>   This is a step towards enabling devices that use multiplexed pins
>   - including ethernet - on boards that use the r8a7796 SoC.

Note that so far no device pinctrl configuration (incl. ethernet ;-) is done...

r8a77995

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
