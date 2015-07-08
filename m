From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Wed, 8 Jul 2015 11:07:09 +0530
Subject: [PATCH 01/41] clocksource: asm9260: Migrate to new 'set-state'
 interface
In-Reply-To: <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <559CB705.5010805@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 June 2015 04:24 PM, Viresh Kumar wrote:
> Migrate asm9260 driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
> 
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.

Hi Viresh,

Is this series (and other one touching arch/arm/*) specific to ARM event timers.
Are you planning to fixup the drivers in arch/* or the respective maintainers need
to follow suit.

Thx,
-Vineet
