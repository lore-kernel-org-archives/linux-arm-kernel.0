From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 11 Oct 2012 14:41:40 +0100
Subject: [PATCH 4/8] cpufreq: db8500: Fetch cpufreq table from platform
 data
In-Reply-To: <1349869349-8070-5-git-send-email-ulf.hansson@stericsson.com>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
 <1349869349-8070-5-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121011134140.GA15428@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -static struct cpufreq_frequency_table freq_table[] = {
> -	[0] = {
> -		.index = 0,
> -		.frequency = 200000,
> -	},
> -	[1] = {
> -		.index = 1,
> -		.frequency = 400000,
> -	},
> -	[2] = {
> -		.index = 2,
> -		.frequency = 800000,
> -	},
> -	[3] = {
> -		/* Used for MAX_OPP, if available */
> -		.index = 3,
> -		.frequency = CPUFREQ_TABLE_END,
> -	},
> -	[4] = {
> -		.index = 4,
> -		.frequency = CPUFREQ_TABLE_END,
> -	},
> -};

So where has this table gone? Am I missing a patch?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
