From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 16 Dec 2015 09:44:46 +0530
Subject: [PATCH v5 0/3] thermal: mediatek: Add cpu dynamic power cooling
 model.
In-Reply-To: <1450238356-36319-1-git-send-email-dawei.chien@mediatek.com>
References: <1450238356-36319-1-git-send-email-dawei.chien@mediatek.com>
Message-ID: <20151216041446.GE3111@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-12-15, 11:59, Dawei Chien wrote:
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
> Change since V4:
> 1. Remove unnecessary error-checking for mt8173-cpufreq.c
> 2. Initializing variable capacitance with 0

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
