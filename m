From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 8 Aug 2013 10:19:05 -0400
Subject: [PATCH 21/35] cpufreq: omap: use cpufreq_table_validate_and_show()
In-Reply-To: <0cc200b71d5c1584c80845a1384aef1919fd779b.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
 <0cc200b71d5c1584c80845a1384aef1919fd779b.1375964117.git.viresh.kumar@linaro.org>
Message-ID: <5203A8D9.6080901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 August 2013 09:48 AM, Viresh Kumar wrote:
> Lets use cpufreq_table_validate_and_show() instead of calling
> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
