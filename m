From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat, 23 Apr 2016 22:05:30 -0500
Subject: [PATCH v6 07/10] irqchip/gic-v3: Parse and export virtual GIC
 information
In-Reply-To: <1460388780-914-8-git-send-email-julien.grall@arm.com>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-8-git-send-email-julien.grall@arm.com>
Message-ID: <571C37FA.2020802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/11/2016 10:32 AM, Julien Grall wrote:
> Fill up the recently introduced gic_kvm_info with the hardware
> information used for virtualization.
>
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>

Using the Qualcomm Technologies QDF2XXX server platform.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
