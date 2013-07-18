From: john.stultz@linaro.org (John Stultz)
Date: Wed, 17 Jul 2013 20:41:07 -0700
Subject: [PATCH 0/3] Cleanup sched_clock.h users
In-Reply-To: <1374115161-675-1-git-send-email-sboyd@codeaurora.org>
References: <1374115161-675-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <51E763D3.4000308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 07:39 PM, Stephen Boyd wrote:
> This patchset cleans up the last few stragglers using the sched_clock.h
> header file in asm and removes the asm header.
>
> A new one appeared in drivers/clocksource so I'm not sure who
> wants to take that one.

Thanks for doing this!

I'll queue the drivers/clocksource one on its own in a separate branch, 
that way I'll merge it into my own 3.12 queue, and Arnd/Olof can also 
merge just that change it in before they drop the asm/sched_clock.h header.

I just pushed it out here:

git://git.linaro.org/people/jstultz/linux.git fortglx/3.12/sched-clock-cleanups


thanks
-john
