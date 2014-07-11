From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Jul 2014 20:07:42 +0530
Subject: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <53BFF132.3020700@nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
 <53BFF132.3020700@nvidia.com>
Message-ID: <CAKohpon_YKkRP+iYnUaE14fKmcSx_SfWVHPiA48BGiPTCPHTKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 July 2014 19:44, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> Sure, I can do the CPU clock parent change first and then instantiate the
> cpufreq-cpu0 driver, like highbank-cpufreq. That'll depend on the patch
> 'cpufreq: cpu0: OPPs can be populated at runtime' from your 'Extend support
> beyond CPU0' series though, any idea when that patch will land in?

So, after your mail I had a chat with Rafael. As this patch happens to be a
fix, we will try to take it into 3.16 only (I am going to send few patches out
of that series separately in few mins). Otherwise 3.17 is where most of it
should go.

Thanks for your agreement to make our life easier :)
