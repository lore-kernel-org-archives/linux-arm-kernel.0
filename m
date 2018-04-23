From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 23 Apr 2018 09:45:07 +0200
Subject: [PATCH 0/8] arm: renesas: Change platform dependency to
 ARCH_RENESAS
In-Reply-To: <20180420164811.GC22369@sirena.org.uk>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <20180420164811.GC22369@sirena.org.uk>
Message-ID: <CAMuHMdUt3ExAD7KEiBhntcOoSWSLMnpNT1Oix4tNRMAM=8g9jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Apr 20, 2018 at 6:48 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 20, 2018 at 03:28:26PM +0200, Geert Uytterhoeven wrote:
>> The first 6 patches can be applied independently by subsystem
>> maintainers.
>> The last two patches depend on the first 6 patches, and are thus marked
>> RFC.
>
> Would it not make sense to try to apply everything en masse rather than
> delaying?  I'm happy to apply the subsystem stuff but if it gets things
> done quicker or more efficiently I'm also happy to have the lot merged
> as one series.

In theory, yes.

However, this touches multiple subsystems, and it's non-critical, so I don't
want to spent the energy to get this done in a synchronized way.
It's way easier to postpone the last (RFC) patches when everything else
has been applied by subsystem maintainers.

So please apply your part, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
