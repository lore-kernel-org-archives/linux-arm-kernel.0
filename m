From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Apr 2015 17:05:40 +0200
Subject: [GIT PULL] ARM perf updates for 4.1
In-Reply-To: <20150327172246.GN1562@arm.com>
References: <20150327172246.GN1562@arm.com>
Message-ID: <CAMuHMdUvjqYSSTwFcyhn=ChCJWZsqvL1CAVWRgnid0=giD56Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Mar 27, 2015 at 6:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> Will Deacon (1):
>       ARM: pmu: add support for interrupt-affinity property

As most DTSes lack this property, we now get scary warnings:

        CPU PMU: Failed to parse <no-node>/interrupt-affinity[0]

BTW, shouldn't the DT update go in first, or together with the code update?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
