From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 23:16:11 -0700
Subject: [PATCH V3 16/16] cpufreq: dt: Add support for turbo/boost mode
In-Reply-To: <5dba664d47ca399e0ad7a55f2d74688d1300a703.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <5dba664d47ca399e0ad7a55f2d74688d1300a703.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <20150731061611.GP3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29, Viresh Kumar wrote:
> With opp-v2 DT bindings, few OPPs can be used only for the boost mode.
> But using such OPPs require the boost mode to be supported by cpufreq
> driver.
> 
> We will parse DT bindings only during ->init() and so can enable boost
> support only after registering cpufreq driver.
> 
> This enables boost support as soon as any policy has boost/turbo OPPs
> for its CPUs.
> 
> We don't need to disable boost support as that is done by the core, when
> the driver is unregistered.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
