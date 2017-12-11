From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Dec 2017 09:58:51 +0000
Subject: [PATCH v2 13/36] KVM: arm64: Don't deactivate VM on VHE systems
In-Reply-To: <20171207170630.592-14-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
 <20171207170630.592-14-christoffer.dall@linaro.org>
Message-ID: <db6edda5-96ab-04a6-a770-6e50a7ba7dcc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/17 17:06, Christoffer Dall wrote:
> There is no need to reset the VTTBR to zero when exiting the guest on
> VHE systems.  VHE systems don't use stage 2 translations for the EL2&0
> translation regime used by the host.
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
