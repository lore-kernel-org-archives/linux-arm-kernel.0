From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 29 Jun 2017 13:56:18 +0200
Subject: Clocks used by another OS/CPU (was: Re: [RFC PATCH] clk: renesas:
 cpg-mssr: Add interface for critical core clocks)
In-Reply-To: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
Message-ID: <CAMuHMdWRadUCZUycUW3dKJhS__aRRVbV1tXo0umUQ7KHOYQMoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

On Thu, Jun 29, 2017 at 11:27 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> CC clock, ARM, DT, PM people
>
> TL;DR: Clocks may be in use by another CPU not running Linux, while Linux
> disables them as being unused.

> Of course this is not limited to clocks, but also to e.g. PM domains.

BTW, how do you prevent Linux from powering down the CR7 PM domain,
which contains the Cortex R7?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
