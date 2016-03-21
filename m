From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 21 Mar 2016 15:20:49 +0530
Subject: [PATCH] cpufreq: rockchip: add driver
In-Reply-To: <1787319.AFAWVqkdk0@diego>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
 <1787319.AFAWVqkdk0@diego>
Message-ID: <20160321095049.GD27778@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-03-16, 13:56, Heiko St?bner wrote:
> Also, on both the rk3368 as well as the rk3399, you probably want the cluster-
> handling of arm-bL-cpufreq-dt.
> Contrary to its name it is _not_ limited to switching between clusters, but 
> can also control frequencies of multiple cpu-clusters running at the same 
> time.

We aren't adding any new users to bL driver, please use cpufreq-dt as that also
supports multiple clusters now.

-- 
viresh
