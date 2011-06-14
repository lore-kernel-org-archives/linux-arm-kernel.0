From: davidb@codeaurora.org (David Brown)
Date: Mon, 13 Jun 2011 17:17:13 -0700
Subject: [PATCH v7 09/14] ARM: msm: use remapped PPI interrupts for local
	timer
In-Reply-To: <1307964119-4187-10-git-send-email-marc.zyngier@arm.com> (Marc
	Zyngier's message of "Mon, 13 Jun 2011 12:21:54 +0100")
References: <1307964119-4187-1-git-send-email-marc.zyngier@arm.com>
	<1307964119-4187-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <8ya1uyxfera.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13 2011, Marc Zyngier wrote:

> Use the normal interrupt scheme for the local timers by using
> a remapped PPI interrupt.
>
> MSM already had a very similar scheme, though still mixing both
> GIC-specific and generic APIs.
>
> Fixes and ideas courtesy of Stephen Boyd.
>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Reviewed-and-Tested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
