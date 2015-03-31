From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 31 Mar 2015 09:17:59 +0200
Subject: [GIT PULL] clockevents for 4.1
In-Reply-To: <5519AEB2.8050306@linaro.org>
References: <5519AEB2.8050306@linaro.org>
Message-ID: <20150331071759.GB9252@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> 
> Hi Thomas, Ingo,
> 
> this pull request contains the following changes for 4.1:
> 
>  - Made IO endian agnostic for at91 and dw apb timers (Ben Dooks)
> 
>  - Maintained tegra endianess (Dmitry Osipenko)
> 
>  - Enabled the sun4i / sun5i timer for sched_clock, all others winner boards
> have the arch arm timer which is more accurate (Hans de Goede)
> 
>  - Renamed the arch arm timer function name to reflect better its purpose
> (Laurent Pinchart)
> 
>  - Cleaned up the sun5i timer code, replaced the setup_irq by the
> request_irq function and handled the parent clock frequency change with the
> frequency notifiers (Maxime Ripard)
> 
>  - Fixed features declaration for the efm32 timer (Viresh Kumar)
> 
> Thanks !

So I had some comments about one of the patches, and fixes to 
changelogs, so I've applied all but the sun4/5i patches from email to 
move things forward.

The sun4/5i patches conflicted - mind reposting those merged on top of 
the latest tip:timers:core tree?

Thanks!

	Ingo
