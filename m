From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 11:45:26 +0000
Subject: [PATCH 6/9] KVM: arm/arm64: vgic: Get rid of MISR and EISR fields
In-Reply-To: <20170320105818.20481-7-cdall@linaro.org>
References: <20170320105818.20481-1-cdall@linaro.org>
 <20170320105818.20481-7-cdall@linaro.org>
Message-ID: <17272a3a-0408-77ee-8f46-58eb5d7db029@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/17 10:58, Christoffer Dall wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> We don't use these fields anymore so let's nuke them completely.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
