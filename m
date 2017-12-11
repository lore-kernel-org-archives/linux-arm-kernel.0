From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Dec 2017 09:54:00 +0000
Subject: [PATCH v2 12/36] KVM: arm64: Remove kern_hyp_va() use in VHE
 switch function
In-Reply-To: <20171207170630.592-13-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
 <20171207170630.592-13-christoffer.dall@linaro.org>
Message-ID: <bba53b66-a652-0912-3ae1-e35269af928c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/17 17:06, Christoffer Dall wrote:
> VHE kernels run completely in EL2 and therefore don't have a notion of
> kernel and hyp addresses, they are all just kernel addresses.  Therefore
> don't call kern_hyp_va() in the VHE switch function.
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
