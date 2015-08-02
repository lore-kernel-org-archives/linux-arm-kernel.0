From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 2 Aug 2015 12:57:08 +0530
Subject: [PATCH v6 0/4] Add Mediatek MT8173 cpufreq driver
In-Reply-To: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
References: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <CAKohpo=jnXkcbE-2N7BVPnuNBQz=zX97Eydc0NwFXSaCcZZJLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 July 2015 at 15:57, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> MT8173 is a ARMv8 based SoC with 2 clusters. All CPUs in a single cluster
> share the same power and clock domain. This series tries to add cpufreq support
> for MT8173 SoC.
>
> changes in v6:
> - Move clock and regulator consumer properties document to the device tree
>   bindings documents of MT8173 CPU DVFS clock driver
> - Add change log to describe what is implemented in the MT8173 cpufreq driver
> - Add missed rcu_read_unlock() in the error path
> - Move of_init_opp_table() call to make sure all required hardware resources
>   are already there before it is called
> - Add comments to describe why both platform driver and deivce registration
>   codes are put in the initcall function
> - Use the term "voltage tracking" instead of "voltage trace" according to an
>   internal SoC document
>

@Rafael: Can you please apply these patches [1,3,4] for 4.3?
