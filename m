From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 8 Sep 2015 08:15:58 +0530
Subject: [PATCH v4 3/4] cpufreq-dt: add suspend frequency support
In-Reply-To: <1441640501-13613-4-git-send-email-b.zolnierkie@samsung.com>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
 <1441640501-13613-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150908024558.GE26760@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-09-15, 17:41, Bartlomiej Zolnierkiewicz wrote:
> +#ifdef CONFIG_PM
> +	.suspend = cpufreq_generic_suspend,
> +#endif

I don't think there is any need of the #ifdef here.

-- 
viresh
