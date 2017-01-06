From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 6 Jan 2017 09:44:42 +0530
Subject: [PATCH v4 2/2] cpufreq: brcmstb-cpufreq: CPUfreq driver for
 older Broadcom STB SoCs
In-Reply-To: <20161220225530.96699-3-code@mmayer.net>
References: <20161220225530.96699-1-code@mmayer.net>
 <20161220225530.96699-3-code@mmayer.net>
Message-ID: <20170106041442.GD21926@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20-12-16, 14:55, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> This CPUfreq driver provides basic frequency scaling for older Broadcom
> STB SoCs that do not use AVS firmware with DVFS support. There is no
> support for voltage scaling.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/Kconfig.arm       |  12 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/brcmstb-cpufreq.c | 377 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 390 insertions(+)
>  create mode 100644 drivers/cpufreq/brcmstb-cpufreq.c

I am fine with this patch as I have already Acked V3 of it. But please fix the
bindings improvement suggested by Stephen first.

-- 
viresh
