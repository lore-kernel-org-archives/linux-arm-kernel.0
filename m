From: John.Linn@xilinx.com (John Linn)
Date: Fri, 23 Sep 2011 14:53:40 -0600
Subject: [RFC PATCH 11/14] ARM: zynq: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1316796692-15964-12-git-send-email-marc.zyngier@arm.com>
References: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
	<1316796692-15964-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <3836bdde-2683-448d-ac86-54cfc98ce55e@VA3EHSMHS009.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> Sent: Friday, September 23, 2011 10:51 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: John Linn
> Subject: [RFC PATCH 11/14] ARM: zynq: convert to
> CONFIG_MULTI_IRQ_HANDLER
> 
> Convert the zynq platform to be using the gic_handle_irq
> function as its primary interrupt handler.
> 
> Cc: John Linn <john.linn@xilinx.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

It seems like if I see any issues I can always go back to the previous
solution as this is not required for our platform. But it's nice to stay
in sync with everyone else.

Acked-by: John Linn <john.linn@xilinx.com>

Thanks,
John

Please ignore the following legal footer that I'm trying to get taken
off.

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
