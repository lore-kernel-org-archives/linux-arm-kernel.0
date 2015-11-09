From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Nov 2015 09:08:08 +0100
Subject: [PATCH v6 00/12] arm64: renesas: add sound support
In-Reply-To: <20151109012943.GF4832@verge.net.au>
References: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
 <20151109012943.GF4832@verge.net.au>
Message-ID: <CAMuHMdXBQNCibJU4EDuFZX0zRzUZfC_4KTyXFNVLL81a51Q4RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Nov 9, 2015 at 2:29 AM, Simon Horman <horms@verge.net.au> wrote:
>>       arm64: renesas: salvator-x: Sound SSI PIO support
>
> The above patch seemed to have some fuzz. Please check that
> I resolved that correctly.

The ak4613 node is now a child node of scif2 instead of i2c2, which is
definitely not correct.

"git diff topic/r8a7795-sound-v5..topic/r8a7795-sound-v6" will show you.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
