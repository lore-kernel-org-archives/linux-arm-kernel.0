From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 3 Dec 2015 11:05:06 +0000
Subject: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420, and
 5422
In-Reply-To: <20151203060527.GH4302@ubuntu>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
 <20151203060527.GH4302@ubuntu>
Message-ID: <566021E2.6070000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/12/15 06:05, Viresh Kumar wrote:

[...]
>
> @Sudeep: What would it take you to use cpufreq-dt for ARM's platforms
> ?
>

The main difference is that we get the OPPs from the firmware rather
than DT. We may just need to abstract that part and we should be able to
use it. I will have a look at it and get back to you will more details.
It has been a while since I looked at cpufreq-dt.

-- 
Regards,
Sudeep
