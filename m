From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Feb 2016 17:19:22 +0000
Subject: [PATCH v2 1/7] irqchip/gic-v3: always return IRQ_SET_MASK_OK_DONE
 in gic_set_affinity
In-Reply-To: <1455110583-19515-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1455110583-19515-1-git-send-email-antoine.tenart@free-electrons.com>
 <1455110583-19515-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <56BB711A.2070301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/16 13:22, Antoine Tenart wrote:
> Always return IRQ_SET_MASK_OK_DONE instead of IRQ_SET_MASK_OK when the
> affinity has been updated. When using stacked irqchips, returning
> IRQ_SET_MASK_OK_DONE means skipping all descendant irqchips.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
