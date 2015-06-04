From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 4 Jun 2015 14:19:04 -0700
Subject: [PATCH v3 4/5] clk: scpi: add support for cpufreq virtual device
In-Reply-To: <1432720398-5701-5-git-send-email-sudeep.holla@arm.com>
References: <1432720398-5701-1-git-send-email-sudeep.holla@arm.com>
 <1432720398-5701-5-git-send-email-sudeep.holla@arm.com>
Message-ID: <20150604211904.GO676@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27, Sudeep Holla wrote:
> The clocks for the CPUs are provided by SCP and are managed by this
> clock driver. So the cpufreq device needs to be added only after the
> clock get registered and removed when this driver is unloaded.
> 
> This patch manages the cpufreq virtual device based on the clock
> availability.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
> Cc: linux-clk at vger.kernel.org
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>


I guess there's no better place for this right now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
