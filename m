From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Sep 2013 15:31:01 +0100
Subject: [PATCH 175/228] cpufreq: sa11x0: Convert to light weight
 ->target_index() routine
In-Reply-To: <84ed2fae0095e526e0665f5859d39d3ff22c7613.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <84ed2fae0095e526e0665f5859d39d3ff22c7613.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130913143101.GW12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 06:32:01PM +0530, Viresh Kumar wrote:
> This patch converts existing .target() to newly defined light weight
> .target_index() routine for this driver.
> 
> CPUFreq core will call cpufreq_frequency_table_target() before calling this
> routine and will pass index to it.
> 
> Some existing routines are no more required and so are removed now.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
