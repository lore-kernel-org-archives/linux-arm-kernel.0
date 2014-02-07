From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 7 Feb 2014 13:08:17 -0800
Subject: [PATCH v2 02/10] genirq: Add devm_request_any_context_irq()
In-Reply-To: <52D5A266.5000504@codeaurora.org>
References: <1388709460-19222-1-git-send-email-sboyd@codeaurora.org>
 <1388709460-19222-3-git-send-email-sboyd@codeaurora.org>
 <52CB2D29.3050107@codeaurora.org> <52D5A266.5000504@codeaurora.org>
Message-ID: <20140207210816.GD12815@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14, Stephen Boyd wrote:
> On 01/06/14 14:24, Stephen Boyd wrote:
> > On 01/02/14 16:37, Stephen Boyd wrote:
> >> Some drivers use request_any_context_irq() but there isn't a
> >> devm_* function for it. Add one so that these drivers don't need
> >> to explicitly free the irq on driver detach.
> >>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > Thomas, can you please review this patch?
> 
> ping?

ping?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
