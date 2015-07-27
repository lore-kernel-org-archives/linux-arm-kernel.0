From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 27 Jul 2015 18:37:08 +0200
Subject: [PATCH V2 10/11] opp: Add helpers for initializing CPU OPPs
In-Reply-To: <8bc35e1fd3ac581f2b96929e331c01d1287aca27.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
 <8bc35e1fd3ac581f2b96929e331c01d1287aca27.1437972635.git.viresh.kumar@linaro.org>
Message-ID: <2526828.VLyJR8Xy8B@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, July 27, 2015 10:32:40 AM Viresh Kumar wrote:
> With "operating-points-v2" its possible to tell which devices share
> OPPs. We already have infrastructure to decode that information.
> 
> This patch adds following APIs:
> - of_get_cpus_sharing_opps: Returns cpumask of CPUs sharing OPPs (only
>   valid with v2 bindings).
> - of_cpumask_init_opp_table: Initializes OPPs for all CPUs present in
>   cpumask.
> - of_cpumask_free_opp_table: Frees OPPs for all CPUs present in cpumask.
> 
> - set_cpus_sharing_opps: Sets which CPUs share OPPs (only valid with old
>   OPP bindings, as this information isn't present in DT).
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
