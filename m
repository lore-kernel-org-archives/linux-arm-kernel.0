From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Dec 2017 13:53:00 +0000
Subject: [PATCH v2 27/36] KVM: arm64: Move common VHE/non-VHE trap config
 in separate functions
In-Reply-To: <20171207170630.592-28-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
 <20171207170630.592-28-christoffer.dall@linaro.org>
Message-ID: <838f808d-c367-be79-80ec-2fce2b6d55db@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/17 17:06, Christoffer Dall wrote:
> As we are about to be more lazy with some of the trap configuration
> register read/writes for VHE systems, move the logic that is currently
> shared between VHE and non-VHE into a separate function which can be
> called from either the world-switch path or from vcpu_load/vcpu_put.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
