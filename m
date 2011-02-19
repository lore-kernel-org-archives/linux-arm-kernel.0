From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 19 Feb 2011 22:14:31 +0100
Subject: [GIT PULL] ARM: PMU for U8500
In-Reply-To: <AANLkTikie8ZsTAv3fkS0AcVXpKhS3r8U8idajP3U=Mz8@mail.gmail.com>
References: <AANLkTikie8ZsTAv3fkS0AcVXpKhS3r8U8idajP3U=Mz8@mail.gmail.com>
Message-ID: <AANLkTi=XV+xWHOEAnnmRM41aS5z+YN8gH5OXePvo9Teh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/17 Linus Walleij <linus.walleij@linaro.org>:

> Russell, could you please pull:
>
> ? ? git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> pmu-for-rmk
>
> This is two patches giving us PMU support on the weird
> single-PMU-irq U8500.
>
> This is based on 2.6.38-rc4 and is identical to the v2
> patchset which was Acked by Will Deacon.
>
> Rabin Vincent (2):
> ?ARM: perf_event: allow platform-specific interrupt handler
> ?mach-ux500: DB8500 PMU support

I don't know why I missed to include the mailing list on this
one. :-(

I've included both patches in ux500-core so we get some -next
testing, at the begining of the patch series so they can be pulled
into your tree without any conflicts in -next if you decide to do
so.

Should be OK, but if the first patch disturbs anything in the
ARM tree merge with -next due to something else messing
around with the PMU files I will happily take it out again.

Yours,
Linus Walleij
