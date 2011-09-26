From: davidb@codeaurora.org (David Brown)
Date: Mon, 26 Sep 2011 13:18:36 -0700
Subject: [PATCH v3 0/3] genirq: handling GIC per-cpu interrupts
In-Reply-To: <1316793788-14500-1-git-send-email-marc.zyngier@arm.com>
References: <1316793788-14500-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110926201836.GA27355@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 05:03:05PM +0100, Marc Zyngier wrote:

> Tested on ARM Versatile Express (Cortex A15), ARM RealView PB11MP,
> OMAP4 (Panda) and Tegra (Harmony). Patch series against next-20110923.
> 
> From v2:
> - Fixed !GENERIC_HARDIRQS build
> - Fixed request_percpu_irq documentation
> 
> From v1:
> - General tidy-up after Thomas' review. I've kept the config option
>   for the time being until we can sort out the anonymous union
>   problem.
> 
> Marc Zyngier (3):
>   genirq: add support for per-cpu dev_id interrupts
>   ARM: gic: consolidate PPI handling
>   ARM: gic, local timers: use the request_percpu_irq() interface

I've tested this on an MSM8660 based off of next-20110926.

Tested-by: David Brown <davidb@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
