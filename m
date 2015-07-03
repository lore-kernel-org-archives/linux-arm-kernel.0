From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 3 Jul 2015 19:02:22 +0200
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <20150703143703.GB19284@katana>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
Message-ID: <CAMuHMdWQeYA=LrYcsD8W_0ZQUp3BKYVxedhBDpD5kPQp++yu1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Fri, Jul 3, 2015 at 4:37 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> So this is a single core machine and uses the em_sti timer w/o the
>> broadcast nonsense. In Simons case it looks like em_sti is used as
>> broadcast device.
>
> We use the same board. Just my kernel has SMP=n.

Unlike our other multi-core A9 SoCs, emev2.dtsi doesn't have a node
for the arm,cortex-a9-twd-timer?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
