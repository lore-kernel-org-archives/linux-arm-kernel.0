From: davidb@codeaurora.org (David Brown)
Date: Tue, 05 Jul 2011 11:06:42 -0700
Subject: [PATCH v8 09/14] ARM: msm: use remapped PPI interrupts for local
	timer
In-Reply-To: <1309855755-6261-10-git-send-email-marc.zyngier@arm.com> (Marc
	Zyngier's message of "Tue, 5 Jul 2011 09:49:10 +0100")
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
	<1309855755-6261-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <8ya1uy461ql.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05 2011, Marc Zyngier wrote:

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

Tested-By: David Brown <davidb@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
