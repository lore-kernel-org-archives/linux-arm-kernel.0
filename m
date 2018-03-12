From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 12 Mar 2018 12:43:36 +0000
Subject: [PATCH 21/27] cpufreq: scpi: Don't validate the frequency table
 twice
In-Reply-To: <9a5c962bd3a225cfa87d6dcb0f6bb85697991c66.1519620578.git.viresh.kumar@linaro.org>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
 <9a5c962bd3a225cfa87d6dcb0f6bb85697991c66.1519620578.git.viresh.kumar@linaro.org>
Message-ID: <96a6904f-2328-c316-4852-937772f95402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/02/18 05:09, Viresh Kumar wrote:
> The cpufreq core is already validating the CPU frequency table after
> calling the ->init() callback of the cpufreq drivers and the drivers
> don't need to do the same anymore. Though they need to set the
> policy->freq_table field directly from the ->init() callback now.
> 
> Stop validating the frequency table from scpi driver.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

FWIW,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
