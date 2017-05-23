From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 May 2017 18:10:23 +0100
Subject: [PATCH v2 3/9] KVM: arm/arm64: Move irq_is_ppi() to header file
In-Reply-To: <20170516184556.26785-4-cdall@linaro.org>
References: <20170516184556.26785-1-cdall@linaro.org>
 <20170516184556.26785-4-cdall@linaro.org>
Message-ID: <89561287-b656-ec0d-2e00-95cdd3c0c2cd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/17 19:45, Christoffer Dall wrote:
> We are about to need this define in the arch timer code as well so move
> it to a common location.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
