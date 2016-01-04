From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 4 Jan 2016 21:42:59 +0100
Subject: [PATCH v2] ARM: shmobile: alt: Add QSPI device to DT
In-Reply-To: <20160104203136.GB12748@verge.net.au>
References: <1451903819-19218-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVFC1TEeTT5Gas8jz0Tvn2HB3EHBo7gp6pthsnOo6x5UQ@mail.gmail.com>
 <20160104203136.GB12748@verge.net.au>
Message-ID: <CAMuHMdWbFHLKgkn9ShJkyyimpwJAbbL5TjqEp1E9GBteVKQmKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Jan 4, 2016 at 9:31 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Jan 04, 2016 at 12:15:10PM +0100, Geert Uytterhoeven wrote:
>> On Mon, Jan 4, 2016 at 11:36 AM, Simon Horman
>> <horms+renesas@verge.net.au> wrote:
>> > Enable the QSPI controller in the alt device tree.
>> >
>> > Based similar work for the silk board by by Vladimir Barinov and
>> > Sergei Shtylyov.
>> >
>> > Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks, I have queued this up for v4.6.
>
> Should we document "spansion,s25fl512s" for the benefit of checkpatch.pl?

Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt used to point to
drivers/mtd/devices/m25p80.c for the list of supported chips.

That seems to have been changed lately. Now jedec,spi-nor.txt includes the
list, but lacks the manufacturers' names, so checkpatch.pl is still not happpy.

Brian: Shouldn't the manufacturers's names be added?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
