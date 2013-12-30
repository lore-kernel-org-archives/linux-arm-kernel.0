From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 30 Dec 2013 14:43:53 +0100
Subject: [PATCH v2 6/8] [RFC] Documentation: dt: Add Renesas RSPI/QSPI
 bindings
In-Reply-To: <20131230125845.GX31886@sirena.org.uk>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
 <1388175362-17132-7-git-send-email-geert@linux-m68k.org>
 <20131230125845.GX31886@sirena.org.uk>
Message-ID: <CAMuHMdXYH6KmH3ZstAvhqUpqXWEbg6sjdUTDRZUrUthdPg-6aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 1:58 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Dec 27, 2013 at 09:16:00PM +0100, Geert Uytterhoeven wrote:
>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>> Cc: devicetree at vger.kernel.org
>
> You've not CCed any maintainers on any of this stuff so I'm assuming you
> don't want any review or the patches applying.  You should in general

Sorry, this was indeed not meant to be applied yet, hence the [RFC].
Will CC you explicitly next time.

> always CC maintainers, things that only go to the list can easily be
> missed.  However I did take a brief look...

Thanks!

>> +- num-cs        : Number of chip selects
>
> Why is this variable and how does this map onto hardware?

It's my understanding that legacy RSPi on SH7757 has 2 chip selects,
while other RSPI implementations have 1 chip select.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
