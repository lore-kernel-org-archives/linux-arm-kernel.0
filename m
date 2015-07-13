From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 13 Jul 2015 08:22:24 +0530
Subject: [PATCH 00/18] ARM: Migrate clockevent drivers to 'set-state'
In-Reply-To: <cover.1436178990.git.viresh.kumar@linaro.org>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
Message-ID: <20150713025224.GF10415@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06-07-15, 16:24, Viresh Kumar wrote:
> Hi Guys,
> 
> This series migrates ARM clockevent drivers (present in arch/arm/
> directory), to the new set-state interface. This would enable these
> drivers to use new states (like: ONESHOT_STOPPED, etc.) of a clockevent
> device (if required), as the set-mode interface is marked obsolete now
> and wouldn't be expanded to handle new states.
> 
> Rebased over: v4.2-rc1
> 
> Following patches:
>   ARM/ks8695/time: Migrate to new 'set-state' interface
>   ARM/omap1/time: Migrate to new 'set-state' interface
> 
> must be integrated to mainline kernel via clockevents tree, because of
> dependency on:
>   352370adb058 ("clockevents: Allow set-state callbacks to be optional")

Arnd,

This dependency patch is applied to 4.2-rc2 now and you can pick all
the patches from this series. Please let me know if you need my help.

-- 
viresh
