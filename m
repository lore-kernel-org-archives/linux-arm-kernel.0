From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 26 Apr 2013 09:49:46 -0700
Subject: [V2 PATCH] cpuidle: add maintainer entry
In-Reply-To: <1366974344-26064-1-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Fri, 26 Apr 2013 13:05:44 +0200")
References: <1366974344-26064-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87txmtz179.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> Currently the cpuidle drivers are spread across the different archs.
>
> The patch submission for cpuidle are following different path: the cpuidle core
> code goes to linux-pm, the ARM drivers goes to arm-soc or the SoC specific
> tree, sh goes through sh arch tree, pseries goes through PowerPC and
> finally intel goes through Len's tree while acpi_idle goes under linux-pm.
>
> That makes difficult to consolidate the code and to propagate modifications
> from the cpuidle core to the different drivers.
>
> Hopefully, a movement has initiated to put the cpuidle drivers into the
> drivers/cpuidle directory like cpuidle-calxeda.c and cpuidle-kirkwood.c
>
> Add an explicit maintainer entry in the MAINTAINER to clarify the situation
> and prevent new cpuidle drivers to goes to an arch directory.
>
> The upstreaming process is unchanged: Rafael takes the patches to merge them
> into its tree but with the acked-by from the driver's maintainer. So the header
> must contains the name of the maintainer.
>
> This organization will be the same than cpufreq.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Andrew Lunn <andrew@lunn.ch>  #for kirkwood
> Acked-by: Jason Cooper <jason@lakedaemon.net> #for kirkwood

Acked-by: Kevin Hilman <khilman@linaro.org>
