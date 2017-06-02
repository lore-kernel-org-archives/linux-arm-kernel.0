From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 2 Jun 2017 11:13:09 +0100
Subject: [PATCH v3 0/4] irqchip: armada-370-xp: remove IRQ_NOAUTOEN
 workaround
In-Reply-To: <1495094860-24709-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1495094860-24709-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <2c29e445-b703-b772-d11d-d73457a6164a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/17 09:07, Thomas Petazzoni wrote:
> Hello,
> 
> This is the third version of a patch series initially posted in
> October 2015, under the title:
> 
>   [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
> 
> at the time, the regression was worked around in commit
> 353d6d6c82e5d2533ba22e7f9fb081582bf50dc2 ("irqchip/armada-370-xp: Fix
> regression by clearing IRQ_NOAUTOEN") and this series brings the
> proper fix for the original issue, while reverting the work around.

I've queued this for 4.13.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
