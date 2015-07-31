From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 23:11:08 -0700
Subject: [PATCH V3 13/16] cpufreq: Update boost flag while initializing
 freq table from OPPs
In-Reply-To: <62971ce19528d707b89e6521f50779fef3ecf145.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <62971ce19528d707b89e6521f50779fef3ecf145.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <20150731061108.GM3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29, Viresh Kumar wrote:
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> cpufreq table entries for OPPs with turbo modes enabled, should be
> marked with CPUFREQ_BOOST_FREQ flag. This ensures that these states are
> only used while operating in boost or turbo mode.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
