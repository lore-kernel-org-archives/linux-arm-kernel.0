From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 13 Jan 2014 13:17:18 +0100
Subject: [PATCH 1/9] spi: rspi: Add missing clk_disable() calls in error
 and cleanup paths
In-Reply-To: <20140113115947.GL29039@sirena.org.uk>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
 <1389525222-3482-2-git-send-email-geert@linux-m68k.org>
 <20140113115947.GL29039@sirena.org.uk>
Message-ID: <CAMuHMdVjkWD0nP-9f579kUOqG4EVsy9Yp+vwNsM_=LxNU=Bdzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Jan 13, 2014 at 12:59 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Jan 12, 2014 at 12:13:34PM +0100, Geert Uytterhoeven wrote:
>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>
> This doesn't seem to apply to current code, please check and resend.
> The fact that there's multiple patch serieses in flight from you for
> this driver plus development work (again mostly from you) in git is
> probably not helping here...

This depends on the series:

[PATCH V2 0/8] spi: rspi: Add support for RZ/A1H

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
