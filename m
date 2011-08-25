From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 25 Aug 2011 13:49:33 +0200
Subject: [PATCH 0/2] OMAP: Update nr_irqs field in machine descriptors
In-Reply-To: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
References: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
Message-ID: <4E5636CD.4080302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Venkat,

On 8/24/2011 9:46 PM, S, Venkatraman wrote:
> As part of an effort to get single ARM kernel binary [1],
> multiple  definitions of NR_IRQS under various platforms
> have to be reconciled and abstracted away from common code.
>
> This patch series takes the small step of populating the
> machine descriptors with the pre-existing nr_irqs field.
> Eventually, the common irq handler code will only look at this
> field and not the compile time constant.

Not related to this patch, but still on that topic. The current NR_IRQS 
depends as well on board stuff, like for example : the Phoenix 
IRQs:TWL6030_IRQ_BASE, TWL6040_CODEC_IRQ_BASE.
Is there a plan to get rid of this static defines?

Thanks,
Benoit
