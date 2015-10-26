From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Oct 2015 09:31:15 +0100
Subject: [PATCH v2 0/2] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
In-Reply-To: <CAK7LNATVmVi=4ugv0MgoCUzusphNeAXTC_K-PsXDiTLoCkV4-Q@mail.gmail.com>
References: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
 <20151026081746.GC597@x1>
 <CAK7LNATVmVi=4ugv0MgoCUzusphNeAXTC_K-PsXDiTLoCkV4-Q@mail.gmail.com>
Message-ID: <CAMuHMdXLMRji80Ma9hbUJg_PChS1s2JaGy00L3M3rmyOnYKqHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 9:27 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2015-10-26 17:17 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
>>> This series adds two I2C controller drivers.
>>> (they are completely different IPs.)
>>>
>>> The first one is a very simple FIFO-less I2C controller,
>>> which is used on some older UniPhier SoCs.
>>>
>>> The other one is higher-performance I2C controller with TX/RX FIFO,
>>> used on newer UniPhier SoCs.
>>
>> And you have sent this to me because ... ?
>
>
> No special reason.
>
>
> I sent this series to linux-i2c at vger.kernel.org.
>
> I guess you were automatically CC'ed by scripts/get_maintainer.pl.
>
> Using get_maintainer.pl is a normal process when sending patches, I think.

Please use common sense. It doesn't make much sense to CC everybody who
ever made a minor edit to an affected file.

If checkpatch comes up with more than 5 names, this should ring a bell.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
