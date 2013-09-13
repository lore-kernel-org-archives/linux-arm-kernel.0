From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Sep 2013 15:32:26 +0100
Subject: [PATCH 144/228] cpufreq: sa11x0: use cpufreq_generic_init()
 routine
In-Reply-To: <254e7e912c3817fdf1499bb1ea7be7bc7f3cdbef.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <254e7e912c3817fdf1499bb1ea7be7bc7f3cdbef.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130913143226.GX12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 06:31:30PM +0530, Viresh Kumar wrote:
> Use generic cpufreq_generic_init() routine instead of replicating the same code
> here.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
