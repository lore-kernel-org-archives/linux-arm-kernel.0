From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 28 Dec 2015 08:42:33 +0530
Subject: [PATCH v2 2/3] cpufreq: mt8173: migrate to use
 operating-points-v2 bindings
In-Reply-To: <1451197318-12418-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1451197318-12418-1-git-send-email-pi-cheng.chen@linaro.org>
 <1451197318-12418-3-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <20151228031233.GC3598@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-12-15, 14:21, Pi-Cheng Chen wrote:
> Modify mt8173-cpufreq driver to get OPP-sharing information and set up
> OPP table provided by operating-points-v2 bindings.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
>  drivers/cpufreq/mt8173-cpufreq.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
