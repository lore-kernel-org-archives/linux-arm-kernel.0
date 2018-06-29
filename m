From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 29 Jun 2018 15:24:12 +0530
Subject: [PATCH 2/3] cpufreq: armada-37xx: Add AVS support
In-Reply-To: <20180619124402.902-3-gregory.clement@bootlin.com>
References: <20180619124402.902-1-gregory.clement@bootlin.com>
 <20180619124402.902-3-gregory.clement@bootlin.com>
Message-ID: <20180629095412.q3c7wprdp4yttgth@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-06-18, 14:44, Gregory CLEMENT wrote:
> Armada 37xx supports Adaptive Voltage Scaling and thanks to this patch a
> voltage is associated to each load level.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 163 +++++++++++++++++++++++++-
>  1 file changed, 160 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
