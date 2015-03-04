From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 4 Mar 2015 15:47:46 +0530
Subject: [PATCH v2 1/4] cpufreq-dt: add clock domain and intermediate
 frequency support
In-Reply-To: <CAKohpomw6iDRRMxgmOORzZVeW4h2-LzKOsUcdpUnANcxiAYm+A@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-2-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpomw6iDRRMxgmOORzZVeW4h2-LzKOsUcdpUnANcxiAYm+A@mail.gmail.com>
Message-ID: <CAKohpom+Ls6AiP_wntwCri2gharN7tGu2Dzk4p4Yd0n75BuXdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 15:45, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> +struct cpufreq_cpu_domain {
>> +       struct list_head node;
>> +       cpumask_t cpus;
>> +       unsigned long intermediate_freq;
>
> This should come from DT instead of platform data.

Well, we are getting fixed this in OPP bindings now, so for now
do it from platform data as you have done it. Once OPP-v2 is
around, we will get rid of it ..
