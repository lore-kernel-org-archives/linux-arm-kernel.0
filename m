From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Dec 2017 10:30:03 +0000
Subject: [PATCH v2 18/36] KVM: arm/arm64: Remove leftover comment from
 kvm_vcpu_run_vhe
In-Reply-To: <20171207170630.592-19-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
 <20171207170630.592-19-christoffer.dall@linaro.org>
Message-ID: <ea331ff7-02ad-630e-271e-87ccf394d127@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/17 17:06, Christoffer Dall wrote:
> The comment only applied to SPE on non-VHE systems, so we simply remove
> it.
> 
> Suggested-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M. (Yeah, I made it halfway!)
-- 
Jazz is not dead. It just smells funny...
