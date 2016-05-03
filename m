From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 2 May 2016 17:45:11 -0700
Subject: [PATCH V2 5/7] mvebu: Use dev_pm_opp_set_sharing_cpus() to mark
 OPP tables as shared
In-Reply-To: <e13515db21cb178a8834d50f8b6b68e9b650aaec.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
 <e13515db21cb178a8834d50f8b6b68e9b650aaec.1461727086.git.viresh.kumar@linaro.org>
Message-ID: <20160503004511.GL3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27, Viresh Kumar wrote:
> That will allow us to avoid using cpufreq-dt platform data.
> 
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
