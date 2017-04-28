From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 28 Apr 2017 14:54:56 +0530
Subject: [PATCH 2/2] cpufreq: scpi: use new scpi_ops functions to remove
 duplicate code
In-Reply-To: <1493371296-12465-2-git-send-email-sudeep.holla@arm.com>
References: <1493371296-12465-1-git-send-email-sudeep.holla@arm.com>
 <1493371296-12465-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <20170428092456.GF21517@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28-04-17, 10:21, Sudeep Holla wrote:
> scpi_ops now provide APIs to get the transition_latency and to add
> OPPs to the devices making those logic redundant here.
> 
> This patch makes use of those APIs and removes the redunant code in
> this driver.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 38 ++++++--------------------------------
>  1 file changed, 6 insertions(+), 32 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
