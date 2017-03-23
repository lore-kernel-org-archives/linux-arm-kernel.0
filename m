From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Mar 2017 13:59:51 -0700
Subject: [PATCH 0/5] ARM: OMAP2+: Add and enable operating-points-v2
In-Reply-To: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
Message-ID: <20170323205950.GQ10760@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [170306 07:26]:
> Hi,
> This series adds the necessary changes to get proper operating-points-v2 tables
> for AM335x/AM437x/DRA7xx/AM57xx TI SoCs. Doing this enables the ti-cpufreq
> driver and allows the platform to detect which CPU OPPs are valid for the
> configuration in use and enable them.
> 
> This series adds complete tables for am335x and adds 1GHz support for all
> beaglebone black boards and updates the already merged but unused am437x table
> to match the finalized DT bindings. It also moves the existing dra7xx/am57xx
> OPPs to OPPv2 but does not enable 1.5GHz yet as this requires multiregulator
> support which will come at a later date.
> 
> Also, now that so many TI platforms will depend on the ti-cpufreq driver let's
> add CONFIG_ARM_TI_CPUFREQ to omap2plus_defconfig to enable it as part of the
> default configuration.

Applying all for v4.12 into dt-v2 and defconfig branches.

Thanks,

Tony
