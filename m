From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 03 Sep 2015 15:21:17 +0100
Subject: [PATCH 1/9] KVM: Add kvm_arch_vcpu_{un}blocking callbacks
In-Reply-To: <1440942866-23802-2-git-send-email-christoffer.dall@linaro.org>
References: <1440942866-23802-1-git-send-email-christoffer.dall@linaro.org>
 <1440942866-23802-2-git-send-email-christoffer.dall@linaro.org>
Message-ID: <55E8575D.70603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/15 14:54, Christoffer Dall wrote:
> Some times it is useful for architecture implementations of KVM to know
> when the VCPU thread is about to block or when it comes back from
> blocking (arm/arm64 needs to know this to properly implement timers, for
> example).
> 
> Therefore provide a generic architecture callback function in line with
> what we do elsewhere for KVM generic-arch interactions.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
