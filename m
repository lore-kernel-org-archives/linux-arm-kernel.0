From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Feb 2013 10:48:53 -0800
Subject: [GIT PULL] KVM/ARM virtual GIC and timer
In-Reply-To: <511930D1.8050208@arm.com>
References: <511930D1.8050208@arm.com>
Message-ID: <20130211184853.GB30668@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 05:56:33PM +0000, Marc Zyngier wrote:
> Hi Arnd, Olof,
> 
> This is a pull request for the last few bits of KVM/ARM, namely the
> virtual GIC and timer.
> 
> The dependencies are:
> 	- for-arm-soc/arch-timers (from Will)
> 	- for-rmk/virt/kvm/core (from Will, and already in RMK's tree)
> 	- irqchip/gic-vic-move (from Rob)
> 
> All these dependencies are already in your next/virt branch, and I
> checked that the merge can be done absolutely painlessly (zero 
> conflicts).
> 
> The diffstat is a bit weird, as I generated the pull request against 
> your next/virt branch, and the merge of irqchip/gic-vic-move shows 
> changes that you already have.
> 
> Cheers,
> 
> 	M.

Hi Marc,

I notice some oddities with the patches in this branch. I suspect you've been
applying patches from other developers without adding your own signed-off-by.

For example, 6025002ca11ea015fa633853a0a06fdb0e6b69d3 was committed by you,
but there's no signed-off-by from you. ffbe732b8391982607ca123eca3b2592988e2665
has your signed off, but before Christoffer's(?).  Etc.

Can you please go through and double check your branch contents and
rebuild/rewrite the commit messages to reflect proper signed-off-by?


Thanks!

-Olof
