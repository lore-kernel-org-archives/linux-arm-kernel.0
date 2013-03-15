From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 15 Mar 2013 10:21:18 +0530
Subject: [PATCH 8/8] cpufreq: omap: remove omap-cpufreq
In-Reply-To: <1363294695-658-9-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
 <1363294695-658-9-git-send-email-nm@ti.com>
Message-ID: <CAOh2x=kCWHL-e9wZxgE97BuNpj0uu67t6SwqghBkyZKL5hugDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 2:28 AM, Nishanth Menon <nm@ti.com> wrote:
> We can now use cpufreq-cpu0 driver using DT entries.
> remove the redundant omap-cpufreq driver from the tree.
> Remove MAINTAINERS file entry for the same as well.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: "Beno?t Cousson" <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: linux-omap at vger.kernel.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: cpufreq at vger.kernel.org
> Cc: linux-pm at vger.kernel.org
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  MAINTAINERS                    |    1 -
>  drivers/cpufreq/Kconfig.arm    |    6 -
>  drivers/cpufreq/Makefile       |    1 -
>  drivers/cpufreq/omap-cpufreq.c |  291 ----------------------------------------
>  4 files changed, 299 deletions(-)
>  delete mode 100644 drivers/cpufreq/omap-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
