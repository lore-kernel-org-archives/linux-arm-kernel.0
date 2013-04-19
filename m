From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 19 Apr 2013 15:21:54 -0700
Subject: [V3 patch 04/19] cpuidle: remove en_core_tk_irqen flag
In-Reply-To: <1365770165-27096-5-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Fri, 12 Apr 2013 14:35:50 +0200")
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-5-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87fvymw48t.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> The en_core_tk_irqen flag is set in all the cpuidle driver which
> means it is not necessary to specify this flag.
>
> Remove the flag and the code related to it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>  # for mach-omap2/*
