From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 11:44:37 +0000
Subject: [PATCH 5/9] KVM: arm/arm64: vgic: Get rid of unnecessary
 save_maint_int_state
In-Reply-To: <20170320105818.20481-6-cdall@linaro.org>
References: <20170320105818.20481-1-cdall@linaro.org>
 <20170320105818.20481-6-cdall@linaro.org>
Message-ID: <99019ceb-d811-dad1-c46e-77a9d2d05664@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/17 10:58, Christoffer Dall wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Now when we don't look at the MISR and EISR values anymore, we can get
> rid of the logic to save them in the GIC save/restore code.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
