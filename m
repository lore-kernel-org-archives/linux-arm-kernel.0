From: keshava_mgowda@ti.com (Munegowda, Keshava)
Date: Tue, 11 Sep 2012 13:12:57 +0530
Subject: [PATCH] ARM: OMAP2+: mux: add support for PAD wakeup event handler
In-Reply-To: <20120910183943.GA1303@atomide.com>
References: <1347273528-2056-1-git-send-email-ruslan.bilovol@ti.com>
 <20120910183943.GA1303@atomide.com>
Message-ID: <CAP05o4+sjt7JERPFN1i3kHswOwDL2rVvQcwTMQPBaJPMUXr86Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 12:09 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Ruslan Bilovol <ruslan.bilovol@ti.com> [120910 03:39]:
>> OMAP mux now parses active wakeup events from pad registers and calls
>> corresponding handler, if handler is not registered - corresponding
>> hwmod ISRs once a wakeup is detected.
>> This is useful for cases when routing wakeups to corresponding hwmod
>> ISRs complicates those ISRs handlers (for example, ISR handler may
>> not know who the interrupt source is)
>
> The mux code in arch/arm/mach-omap2 will be going away and replaced
> by device tree based pinctrl-single.

Thanks tony
       when is this device tree based pinctrl-single will be available
in mainline?

regards
keshava
