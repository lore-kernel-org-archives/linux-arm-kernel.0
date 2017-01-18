From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 18 Jan 2017 08:44:55 +0530
Subject: [PATCH v4 1/4] PM / OPP: Expose _of_get_opp_desc_node as
 dev_pm_opp API
In-Reply-To: <20170117131808.29798-2-d-gerlach@ti.com>
References: <20170117131808.29798-1-d-gerlach@ti.com>
 <20170117131808.29798-2-d-gerlach@ti.com>
Message-ID: <20170118031455.GA11478@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-01-17, 07:18, Dave Gerlach wrote:
> Rename _of_get_opp_desc_node to dev_pm_opp_of_get_opp_desc_node and add it
> to include/linux/pm_opp.h to allow other drivers, such as platform OPP
> and cpufreq drivers, to make use of it.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v3->v4:
> 	Export dev_pm_opp_of_get_opp_desc_node for use in modules.
> 	
>  drivers/base/power/opp/of.c | 9 +++++----
>  include/linux/pm_opp.h      | 6 ++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
