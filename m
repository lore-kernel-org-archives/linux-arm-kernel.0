From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Dec 2017 10:22:34 +0000
Subject: [PATCH v2 17/36] KVM: arm64: Introduce separate VHE/non-VHE
 sysreg save/restore functions
In-Reply-To: <20171207170630.592-18-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
 <20171207170630.592-18-christoffer.dall@linaro.org>
Message-ID: <85c08278-268e-1bb8-60e1-9a85be5e61e4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/17 17:06, Christoffer Dall wrote:
> As we are about to handle system registers quite differently between VHE
> and non-VHE systems.  In preparation for that, we need to split some of
> the handling functions between VHE and non-VHE functionality.
> 
> For now, we simply copy the non-VHE functions, but we do change the use
> of static keys for VHE and non-VHE functionality now that we have
> separate functions.
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
