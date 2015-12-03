From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 3 Dec 2015 16:54:46 +0530
Subject: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420, and
 5422
In-Reply-To: <566021E2.6070000@arm.com>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
 <20151203060527.GH4302@ubuntu> <566021E2.6070000@arm.com>
Message-ID: <20151203112446.GD2097@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-12-15, 11:05, Sudeep Holla wrote:
> The main difference is that we get the OPPs from the firmware rather
> than DT. We may just need to abstract that part and we should be able to
> use it. I will have a look at it and get back to you will more details.
> It has been a while since I looked at cpufreq-dt.

I forgot that :( .. but we can then create OPPs at runtime based on
what's available from firmware. And we also have an API now to set
which CPUs share OPPs... so that might be used as well..

-- 
viresh
