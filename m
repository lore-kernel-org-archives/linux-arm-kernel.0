From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Jul 2013 22:51:09 +0200
Subject: [PATCH v4 00/17] 64-bit friendly generic sched_clock()
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdauSuk9xDSzUFN=OO0yVWZXSMTUuYTVDZb2_zYb=YMW_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 1:21 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> This patchset adds support for 64 bit counters in the generic
> sched_clock code and converts drivers over to use it. Based
> on v3.11-rc1.
>
> Changes since v3:

>   ocksource: dbx500-prcmu: Switch to sched_clock_register()

Fix subject.

>   clocksource: nomadik: Switch to sched_clock_register()

Apart from that Acked-by: Linus Walleij <linus.walleij@linaro.org>
for these two drivers.

BTW: why are you not patching arch/arm/mach-u300/timer.c?
Please make sure to grep for all setup_sched_clock() if you're
going to do this.

Yours,
Linus Walleij
