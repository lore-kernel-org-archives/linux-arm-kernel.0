From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Oct 2015 12:23:31 +0100
Subject: [PATCH 0/2] More GIC updates for Linux 4.4
In-Reply-To: <1444817359-15696-1-git-send-email-marc.zyngier@arm.com>
References: <1444817359-15696-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <561E3B33.6000705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/15 11:09, Marc Zyngier wrote:
> Hi Thomas,
> 
> Here's a couple of GIC patches that I'd like to see in 4.4:
> 
> - A fix for a (copy-paste) bug introduced by the fwnode/fwspec
>   conversion, breaking LPI translation
> 
> - An extension to the GICv2m driver, enabling support for multiple MSI
>   frames (already posted)
> 
> This is on top of tip/irq/core as of yesterday. Hopefully, this is the
> last set of GIC patches for the next merge window (yeah, right...).

"Yeah right" indeed, I fscked-up the conflict resolution on the second
patch. I'm resending another series, sorry for the noise (now I really
need this holiday...).

	M.
-- 
Jazz is not dead. It just smells funny...
