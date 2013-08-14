From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Wed, 14 Aug 2013 10:00:33 +0200
Subject: [PATCH V2 05/35] cpufreq: at32ap: Covert to light weight
 ->target_index() routine
In-Reply-To: <1e8023313384685c4f5488b5249423b066e8c133.1376392602.git.viresh.kumar@linaro.org>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
 <1e8023313384685c4f5488b5249423b066e8c133.1376392602.git.viresh.kumar@linaro.org>
Message-ID: <20130814080033.GA8540@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Tue 13 Aug 2013 19:02:18 +0530 or thereabout, Viresh Kumar wrote:
> This patch converts existing .target() to newly defined light weight
> .target_index() routine for this driver.
> 
> CPUFreq core will call cpufreq_frequency_table_target() before calling this
> routine and will pass index to it.
> 
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/cpufreq/at32ap-cpufreq.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
