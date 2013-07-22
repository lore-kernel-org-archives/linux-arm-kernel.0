From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 22 Jul 2013 09:24:34 -0700
Subject: [PATCH v4 00/17] 64-bit friendly generic sched_clock()
In-Reply-To: <CACRpkdauSuk9xDSzUFN=OO0yVWZXSMTUuYTVDZb2_zYb=YMW_A@mail.gmail.com>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <CACRpkdauSuk9xDSzUFN=OO0yVWZXSMTUuYTVDZb2_zYb=YMW_A@mail.gmail.com>
Message-ID: <20130722162434.GB19639@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20, Linus Walleij wrote:
> On Fri, Jul 19, 2013 at 1:21 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > This patchset adds support for 64 bit counters in the generic
> > sched_clock code and converts drivers over to use it. Based
> > on v3.11-rc1.
> >
> > Changes since v3:
> 
> >   ocksource: dbx500-prcmu: Switch to sched_clock_register()
> 
> Fix subject.
> 
> >   clocksource: nomadik: Switch to sched_clock_register()
> 
> Apart from that Acked-by: Linus Walleij <linus.walleij@linaro.org>
> for these two drivers.
> 
> BTW: why are you not patching arch/arm/mach-u300/timer.c?
> Please make sure to grep for all setup_sched_clock() if you're
> going to do this.

Thanks.

I'll convert the arch/arm users once this series is accepted into
the tip tree. Then send off the rest through the arm-soc tree.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
