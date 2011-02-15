From: davidb@quicinc.com (David Brown)
Date: Mon, 14 Feb 2011 20:13:07 -0800
Subject: [PATCH 1/5] ARM: smp: Select local timers vs dummy timer support
	runtime
In-Reply-To: <1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 12 Feb 2011 16:59:43 +0530")
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <8ya1v3aey0c.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12 2011, Santosh Shilimkar wrote:

> The current code support of dummy timers in absence of local
> timer is compile time. This is an attempt to convert it to runtime
> so that on few SOC version if the local timers aren't supported
> kernel can switch to dummy timers. OMAP4430 ES1.0 does suffer from
> this limitation.
>
> This patch should not have any functional impact on affected
> files.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-msm/timer.c           |    3 ++-

Acked-By: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
