From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 22 May 2017 16:21:38 +0100
Subject: [PATCH v2 1/3] KVM: arm/arm64: Allow GICv2 to supply a uaccess
 register function
In-Reply-To: <20170516100431.4101-2-cdall@linaro.org>
References: <20170516100431.4101-1-cdall@linaro.org>
 <20170516100431.4101-2-cdall@linaro.org>
Message-ID: <2d277bff-da18-f996-8cf3-88dc9b8abf61@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/17 11:04, Christoffer Dall wrote:
> We are about to differentiate between writes from a VCPU and from
> userspace to the GIC's GICD_ISACTIVER and GICD_ICACTIVER registers due
> to different synchronization requirements.
> 
> Expand the macro to define a register description for the GIC to take
> uaccess functions as well.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
