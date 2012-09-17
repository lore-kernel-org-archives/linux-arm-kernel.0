From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Sep 2012 16:35:41 -0700
Subject: [PATCH] ARM: smp: Formalize an IPI for wakeup
In-Reply-To: <1347315869-28285-1-git-send-email-sboyd@codeaurora.org>
References: <1347315869-28285-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5057B3CD.1090805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/12 15:24, Stephen Boyd wrote:
> Remove the offset from ipi_msg_type and assume that SGI0 is the
> wakeup interrupt now that all WFI hotplug users call
> gic_raise_softirq() with 0 instead of 1. This allows us to 
> track how many wakeup interrupts are sent and also removes the
> unknown IPI printk message for WFI hotplug based systems.
>
> Reviewed-by: Nicolas Pitre <nico@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

I'm going to put this into the patch tracker in a few hours if there are
no further comments.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
