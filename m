From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Mar 2018 10:39:56 +0530
Subject: [PATCH v9 14/15] cpufreq: Add module to register cpufreq on
 Krait CPUs
In-Reply-To: <1520347148-27852-15-git-send-email-sricharan@codeaurora.org>
References: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
 <1520347148-27852-15-git-send-email-sricharan@codeaurora.org>
Message-ID: <20180307050956.GA6842@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06-03-18, 20:09, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Register a cpufreq-generic device whenever we detect that a
> "qcom,krait" compatible CPU is present in DT.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> [Sricharan: updated to use dev_pm_opp_set_prop_name and
> 	    nvmem apis]
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm          |  10 ++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   5 +
>  drivers/cpufreq/qcom-cpufreq.c       | 183 +++++++++++++++++++++++++++++++++++
>  4 files changed, 199 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
