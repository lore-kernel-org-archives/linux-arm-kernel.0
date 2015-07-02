From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 1 Jul 2015 18:27:18 -0700
Subject: [PATCH 06/10] OPP: Add clock-latency-ns support
In-Reply-To: <1376f9ac3f955e67bd56327ea0ac9aecd06a6070.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1376f9ac3f955e67bd56327ea0ac9aecd06a6070.1434369079.git.viresh.kumar@linaro.org>
Message-ID: <20150702012718.GC7143@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15, Viresh Kumar wrote:
> With "operating-points-v2" bindings, clock-latency is defined per OPP.
> Users of this value expect a single value which defines the latency to
> switch to any clock rate. Find maximum clock-latency-ns from the OPP
> table to service requests from such users.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
