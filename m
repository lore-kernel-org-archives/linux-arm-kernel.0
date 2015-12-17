From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 17 Dec 2015 07:22:31 +0530
Subject: [PATCH v6 0/3] thermal: mediatek: Add cpu dynamic power cooling
 model.
In-Reply-To: <1450272556-29770-1-git-send-email-dawei.chien@mediatek.com>
References: <1450272556-29770-1-git-send-email-dawei.chien@mediatek.com>
Message-ID: <20151217015231.GC3496@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-12-15, 21:29, Dawei Chien wrote:
> Use Intelligent Power Allocation (IPA) technical to add dynamic power model
> for binding CPU thermal zone. The power allocator governor allocates power
> budget to control CPU temperature.
> 
> Power Allocator governor is able to keep SOC temperature within a defined
> temperature range to avoid SOC overheat and keep it's performance.
> mt8173-cpufreq.c need to register its' own power model with power allocator
> thermal governor, so that power allocator governor can allocates suitable
> power budget to control CPU temperature.
> 
> Binding document is refer to this patchset
> https://lkml.org/lkml/2015/11/30/239
> 
> Change since V5:
> 1. Remove thermal sensor ID from phandles

Though you should have included this in the new version, but still

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
