From: davem@davemloft.net (David Miller)
Date: Fri, 13 Sep 2013 17:45:57 -0400 (EDT)
Subject: [PATCH 054/228] cpufreq: sparc: call
 cpufreq_frequency_table_put_attr()
In-Reply-To: <7baecf8302d921d18afa8fc7447e68e41eb434e8.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <cover.1379063063.git.viresh.kumar@linaro.org>
 <7baecf8302d921d18afa8fc7447e68e41eb434e8.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130913.174557.622678961981086743.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 13 Sep 2013 18:30:00 +0530

> Drivers which have an exit path must call cpufreq_frequency_table_put_attr() if
> they have called cpufreq_frequency_table_get_attr() in their init path.
> 
> This driver was missing this part and is fixed with this patch.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux at vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: David S. Miller <davem@davemloft.net>
