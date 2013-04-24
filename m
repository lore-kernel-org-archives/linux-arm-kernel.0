From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 24 Apr 2013 09:55:27 -0700
Subject: [PATCH] cpuidle: add maintainer entry
In-Reply-To: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Wed, 24 Apr 2013 15:34:23 +0200")
References: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87k3nr50n4.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafael,

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

[...]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61677c3..effa0f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2206,6 +2206,13 @@ S:	Maintained
>  F:	drivers/cpufreq/
>  F:	include/linux/cpufreq.h
>  
> +CPUIDLE DRIVERS
> +M:	Rafael J. Wysocki <rjw@sisk.pl>
> +L:	linux-pm at vger.kernel.org
> +S:	Maintained
> +F:	drivers/cpuidle/*
> +F:	include/linux/cpuidle.h

What do you think about having Daniel listed here as a co-maintainer?

He has been driving a significant consolidation effort, and will
continue to do that, so I think he should help take care of this area
and ensure all drivers are moving in the right direction.

Kevin
