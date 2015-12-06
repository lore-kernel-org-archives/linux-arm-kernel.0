From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 6 Dec 2015 07:54:46 +0530
Subject: [PATCH v2] cpufreq: mt8173: move resources allocation into
 ->probe()
In-Reply-To: <1449295306-9222-1-git-send-email-pi-cheng.chen@linaro.org>
References: <1448785898-17838-4-git-send-email-pi-cheng.chen@linaro.org>
 <1449295306-9222-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <20151206022446.GV3430@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05-12-15, 14:01, Pi-Cheng Chen wrote:
> Since the return value of ->init() of cpufreq driver is not propagated
> to the device driver model now, move resources allocation into
> ->probe() to handle -EPROBE_DEFER properly.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
> v1->v2:
> - fix error handling path in ->probe()

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
