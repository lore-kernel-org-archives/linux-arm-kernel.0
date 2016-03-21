From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 21 Mar 2016 20:43:00 +0530
Subject: [PATCH] cpufreq: rockchip: add driver
In-Reply-To: <56EFF610.6040402@rock-chips.com>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
 <1787319.AFAWVqkdk0@diego> <20160321095049.GD27778@vireshk-i7>
 <1505152.fhSnu3pvDr@diego> <20160321095855.GE27778@vireshk-i7>
 <56EFF610.6040402@rock-chips.com>
Message-ID: <20160321151300.GK27778@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-03-16, 21:24, Feng Xiao wrote:
> Rockchip-cpufreq.c depends on ARM_ROCKCHIP_CPUFREQ, it will not be compiled
> on non-Rockchip platforms.
> The driver can support all Rockchip SoCs up to now, add
> of_machine_is_compatible may be redundant ?

Heard of Multi-platform kernels ?

-- 
viresh
