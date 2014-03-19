From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 19 Mar 2014 12:59:04 +0100
Subject: [PATCH v2 5/7] sched: add a new SD_SHARE_POWERDOMAIN for
 sched_domain
In-Reply-To: <1395165409-18055-6-git-send-email-vincent.guittot@linaro.org>
References: <1395165409-18055-1-git-send-email-vincent.guittot@linaro.org>
 <1395165409-18055-6-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140319115904.GJ27632@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 06:56:47PM +0100, Vincent Guittot wrote:


> @@ -5946,7 +5948,8 @@ static int sched_domains_curr_level;
>  	(SD_SHARE_CPUPOWER |		\
>  	 SD_SHARE_PKG_RESOURCES |	\
>  	 SD_NUMA |			\
> -	 SD_ASYM_PACKING)
> +	 SD_ASYM_PACKING |		\
> +	 SD_SHARE_POWERDOMAIN)

You forgot to update the pretty comment above that :-)
