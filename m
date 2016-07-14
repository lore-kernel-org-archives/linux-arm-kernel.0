From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Jul 2016 14:08:03 +0100
Subject: [patch V2 60/67] KVM/arm/arm64/vgic-new: Convert to hotplug state
 machine
In-Reply-To: <20160713153337.900484868@linutronix.de>
References: <20160713153219.128052238@linutronix.de>
 <20160713153337.900484868@linutronix.de>
Message-ID: <57878EB3.3040606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/16 18:17, Anna-Maria Gleixner wrote:
> From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> 
> Install the callbacks via the state machine and let the core invoke
> the callbacks on the already online CPUs.
> 
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Eric Auger <eric.auger@linaro.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Radim Krcmar <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kvm at vger.kernel.org
> Cc: kvmarm at lists.cs.columbia.edu
> Cc: linux-arm-kernel at lists.infradead.org

For patches 3, 4, 5, 6, 7, 44, 45 and 60:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
