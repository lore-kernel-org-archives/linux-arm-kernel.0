From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Dec 2017 10:40:50 +0000
Subject: [PATCH v2 19/36] KVM: arm64: Unify non-VHE host/guest sysreg save
 and restore functions
In-Reply-To: <20171207170630.592-20-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
 <20171207170630.592-20-christoffer.dall@linaro.org>
Message-ID: <2799bd84-8882-3404-7122-09fc1a0d8937@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/17 17:06, Christoffer Dall wrote:
> There is no need to have multiple identical functions with different
> names for saving host and guest state.  When saving and restoring state
> for the host and guest, the state is the same for both contexts, and
> that's why we have the kvm_cpu_context structure.  Delete one
> version and rename the other into simply save/restore.
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
