From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Oct 2017 15:38:57 +0100
Subject: [PATCH v4 15/20] KVM: arm/arm64: Support EL1 phys timer register
 access in set/get reg
In-Reply-To: <20171020114939.12554-16-christoffer.dall@linaro.org>
 (Christoffer Dall's message of "Fri, 20 Oct 2017 13:49:34 +0200")
References: <20171020114939.12554-1-christoffer.dall@linaro.org>
 <20171020114939.12554-16-christoffer.dall@linaro.org>
Message-ID: <86y3nzb8ce.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20 2017 at  1:49:34 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> From: Christoffer Dall <cdall@linaro.org>
>
> Add suport for the physical timer registers in kvm_arm_timer_set_reg and
> kvm_arm_timer_get_reg so that these functions can be reused to interact
> with the rest of the system.
>
> Note that this paves part of the way for the physical timer state
> save/restore, but we still need to add those registers to
> KVM_GET_REG_LIST before we support migrating the physical timer state.
>
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
