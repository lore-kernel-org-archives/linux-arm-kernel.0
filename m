From: davem@davemloft.net (David Miller)
Date: Fri, 13 Sep 2013 17:46:20 -0400 (EDT)
Subject: [PATCH 042/228] cpufreq: sparc: use
 cpufreq_table_validate_and_show()
In-Reply-To: <454f6bb0c5fa53654e694c82db6ca758410826f5.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <cover.1379063063.git.viresh.kumar@linaro.org>
 <454f6bb0c5fa53654e694c82db6ca758410826f5.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130913.174620.1338104286620840125.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 13 Sep 2013 18:29:48 +0530

> Lets use cpufreq_table_validate_and_show() instead of calling
> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux at vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: David S. Miller <davem@davemloft.net>
