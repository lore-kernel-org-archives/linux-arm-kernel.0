From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 15 Dec 2017 09:57:09 +0530
Subject: [PATCH v2 0/4] PM / OPP: Introduce ti-opp-supply driver
In-Reply-To: <20171215042528.28715-1-d-gerlach@ti.com>
References: <20171215042528.28715-1-d-gerlach@ti.com>
Message-ID: <20171215042709.GC3322@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-12-17, 22:25, Dave Gerlach wrote:
> Hi,
> This is v2 of the series to introduce the ti-opp-supply driver which makes
> use of the OPP core to enable multiple regulator DVFS and AVS Class0 for
> TI DRA7 and AM57 platforms. Version 1 of this series can be found here [1].
> 
> Very few changes since v1, just added Viresh's acks to patches 1 and 2 and
> added SPDX license to the ti-opp-supply driver in patch 4.
> 
> Pushed updated branch here just in case [2].
> 
> Regards,
> Dave
> 
> [1] https://www.spinics.net/lists/devicetree/msg205957.html
> [2] https://github.com/dgerlach/linux-pm/tree/upstream/v4.15/ti-multireg-support-v2
> 
> Dave Gerlach (4):
>   cpufreq: ti-cpufreq: Convert to module_platform_driver
>   cpufreq: ti-cpufreq: Add support for multiple regulators
>   dt-bindings: opp: Introduce ti-opp-supply bindings
>   PM / OPP: Add ti-opp-supply driver
> 
>  .../bindings/opp/ti-omap5-opp-supply.txt           |  63 +++
>  drivers/cpufreq/ti-cpufreq.c                       |  51 ++-
>  drivers/opp/Makefile                               |   1 +
>  drivers/opp/ti-opp-supply.c                        | 425 +++++++++++++++++++++
>  4 files changed, 534 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
>  create mode 100644 drivers/opp/ti-opp-supply.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
