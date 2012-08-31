From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 31 Aug 2012 14:42:38 +0800
Subject: [PATCH v3 0/3] Add a generic cpufreq-cpu0 driver
In-Reply-To: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
References: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120831064236.GB3271@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping, Rafael.

Regards,
Shawn

On Fri, Aug 10, 2012 at 01:37:22PM +0800, Shawn Guo wrote:
> Patch "cpufreq: Add a generic cpufreq-cpu0 driver" has a dependency
> on following branch.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git topic/tol
> 
> Changes since v2:
> * Drop patch "regulator: add a new API regulator_set_voltage_tol()",
>   which has been applied on regulator tree as above.
> * Rewrite function of_init_opp_table to make it concise.
>   
> Regards,
> Shawn
> 
> Richard Zhao (1):
>   ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for smp
> 
> Shawn Guo (2):
>   PM / OPP: Initialize OPP table from device tree
>   cpufreq: Add a generic cpufreq-cpu0 driver
> 
>  .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |   55 ++++
>  Documentation/devicetree/bindings/power/opp.txt    |   25 ++
>  arch/arm/kernel/smp.c                              |   54 ++++
>  drivers/base/power/opp.c                           |   47 ++++
>  drivers/cpufreq/Kconfig                            |   11 +
>  drivers/cpufreq/Makefile                           |    2 +
>  drivers/cpufreq/cpufreq-cpu0.c                     |  271 ++++++++++++++++++++
>  include/linux/opp.h                                |    8 +
>  8 files changed, 473 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
>  create mode 100644 Documentation/devicetree/bindings/power/opp.txt
>  create mode 100644 drivers/cpufreq/cpufreq-cpu0.c
> 
> -- 
> 1.7.5.4
> 
> 
