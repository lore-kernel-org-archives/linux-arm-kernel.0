From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 10 Mar 2017 15:44:52 +0530
Subject: [PATCH v2] cpufreq: qoriq: enhance bus frequency calculation
In-Reply-To: <1489109323-11424-1-git-send-email-andy.tang@nxp.com>
References: <1489109323-11424-1-git-send-email-andy.tang@nxp.com>
Message-ID: <20170310101452.GA26510@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-03-17, 09:28, Yuantian Tang wrote:
> On some platforms, property device-type may be missed in soc node
> in dts which caused the bus-frequency can not be obtained correctly.
> 
> This patch enhanced the bus-frequency calculation. When property
> device-type is missed in dts, bus-frequency will be obtained by
> looking up clock table to get platform clock and hence get its
> frequency.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> ---
> v2: -- fix alignment issue
> 
>  drivers/cpufreq/qoriq-cpufreq.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
