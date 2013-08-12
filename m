From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Aug 2013 15:35:24 +0800
Subject: [PATCH 08/35] cpufreq: cpufreq-cpu0: use
 cpufreq_table_validate_and_show()
In-Reply-To: <59d56d7aea5dfb69bc7bda0c40529d3ef15efcab.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
 <59d56d7aea5dfb69bc7bda0c40529d3ef15efcab.1375964117.git.viresh.kumar@linaro.org>
Message-ID: <20130812073522.GC25061@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 07:18:10PM +0530, Viresh Kumar wrote:
> Lets use cpufreq_table_validate_and_show() instead of calling
> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I'm not copied on the patch that introduces function
cpufreq_table_validate_and_show().  So if it does the right/equivalent
thing, for cpufreq-cpu0 and imx6q-cpufreq:

Acked-by: Shawn Guo <shawn.guo@linaro.org>
