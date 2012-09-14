From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 14 Sep 2012 07:21:51 -0700
Subject: [PATCH] cpufreq: OMAP: remove loops_per_jiffy recalculate for smp
In-Reply-To: <201209072115.08252.rjw@sisk.pl> (Rafael J. Wysocki's message of
 "Fri, 7 Sep 2012 21:15:08 +0200")
References: <1346981022-28011-1-git-send-email-shawn.guo@linaro.org>
 <201209072115.08252.rjw@sisk.pl>
Message-ID: <87sjak8z28.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, September 07, 2012, Shawn Guo wrote:
>> From: Richard Zhao <richard.zhao@freescale.com>
>> 
>> With ARM smp common code recalculating loops_per_jiffy in a cpufreq
>> transiton notifier call, the loops_per_jiffy recalculate in omap-cpufreq
>> driver becomes redundant.  Remove it.
>> 
>> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>
> I suppose that Kevin is going to handle this, right?

Normally, yes, but I'm a bit behind, still catching up from some time
off.

> Kevin, if you want me to pull new material for v3.7, it's about time to get
> it ready.

Rafael, feel free to add this one to your pm-cpufreq branch with

Acked-by: Kevin Hilman <khilman@ti.com>

Also, we have one other OMAP CPUfreq change that needs to go via the
OMAP tree with some corresponding clock changes:

  http://marc.info/?l=linux-omap&m=134740995111966&w=2

Can you ack that one?

Thanks,

Kevin
