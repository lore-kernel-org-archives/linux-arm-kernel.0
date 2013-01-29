From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Jan 2013 10:56:54 +0800
Subject: [PATCH v4] cpufreq: add imx6q-cpufreq driver
In-Reply-To: <1359214303-3319-1-git-send-email-shawn.guo@linaro.org>
References: <1359214303-3319-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130129025652.GB11546@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 11:31:43PM +0800, Shawn Guo wrote:
> Add an imx6q-cpufreq driver for Freescale i.MX6Q SoC to handle the
> hardware specific frequency and voltage scaling requirements.
> 
> The driver supports module build and is instantiated by the platform
> device/driver mechanism, so that it will not be instantiated on other
> platforms, as IMX is built with multiplatform support.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Rafael,

I think the patch needs to go via cpufreq tree, as it has dependency
on Nishanth's "PM / OPP : export symbol consolidation" series.

Shawn
