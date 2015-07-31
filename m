From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 23:15:24 -0700
Subject: [PATCH V3 15/16] cpufreq: dt: Add support for
 operating-points-v2 bindings
In-Reply-To: <c7e42623089a04f1d607f0912736aa1ec1d5c48a.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <c7e42623089a04f1d607f0912736aa1ec1d5c48a.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <20150731061524.GO3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29, Viresh Kumar wrote:
> Support for parsing operating-points-v2 bindings is in place now, lets
> modify cpufreq-dt driver to use them.
> 
> For backward compatibility we will continue to support earlier bindings.
> Special handling for that is required, to make sure OPPs are initialized
> for all the CPUs.
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
