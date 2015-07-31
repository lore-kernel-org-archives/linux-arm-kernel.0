From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 23:24:07 -0700
Subject: [PATCH V3 10/16] PM / OPP: Add support for opp-suspend
In-Reply-To: <3d1b8d7de9f2ad34d979540e367ed691bcb7bb77.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <3d1b8d7de9f2ad34d979540e367ed691bcb7bb77.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <20150731062406.GS3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29, Viresh Kumar wrote:
> With "operating-points-v2" bindings, its possible to specify the OPP to

s/its/it's/ ?

> which the device must be switched, before suspending.
> 
> This patch adds support for getting that information.
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
