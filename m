From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 6 May 2015 16:27:48 +0200
Subject: [RFC v2 0/4] chip/vgic adaptations for forwarded irq
In-Reply-To: <1423642857-24240-1-git-send-email-eric.auger@linaro.org>
References: <1423642857-24240-1-git-send-email-eric.auger@linaro.org>
Message-ID: <20150506142748.GC6796@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Wed, Feb 11, 2015 at 09:20:53AM +0100, Eric Auger wrote:
> This series proposes some fixes that appeared to be necessary
> to integrate IRQ forwarding in KVM/VFIO.
> 
> - deactivation of the forwarded IRQ in irq_disabled case
> - a specific handling of forwarded IRQ into the VGIC state machine.
> - deactivation of physical IRQ and unforwarding on vgic destruction
> - rb_tree lock in vgic.c
> 
> Integrated pieces can be found at
> ssh://git.linaro.org/people/eric.auger/linux.git
> on branch irqfd_integ_v9
> 
What are the dependencies for this at this point?

I assume it relies at least on the split EOI/priority drop changes?

Are you going to respin this when there are newer versions of the
dependencies out, or what are the plans?

Thanks,
-Christoffer
