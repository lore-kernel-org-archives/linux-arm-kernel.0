From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Wed, 8 Jul 2015 06:14:46 +0000
Subject: [PATCH 01/41] clocksource: asm9260: Migrate to new 'set-state'
 interface
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
 <559CB705.5010805@synopsys.com> <20150708054341.GC19130@linux>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665AC7FB@IN01WEMBXB.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 July 2015 11:14 AM, Viresh Kumar wrote:
> On 08-07-15, 11:07, Vineet Gupta wrote:
>> Is this series (and other one touching arch/arm/*) specific to ARM event timers.
>> Are you planning to fixup the drivers in arch/* or the respective maintainers need
>> to follow suit.
> Hi Vineet,
>
> I am fixing all clockevent drivers available in Linux kernel, so you
> need not worry :)

Ok I can go back to sleeping peacefully again ;-)

> Changes are kept here for testing by auto-bots, in case you wanna have
> a look at arc patch :).
>
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git clkevt/clocksource/set-state

LGTM - I'll give it a spin when u send out the series on ml.

Thx,
-Vineet
