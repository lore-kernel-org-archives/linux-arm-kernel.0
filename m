From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 09 Dec 2017 19:20:28 +0000
Subject: [PATCH v2 07/36] KVM: arm64: Move debug dirty flag calculation
 out of world switch
In-Reply-To: <20171207170630.592-8-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
 <20171207170630.592-8-christoffer.dall@linaro.org>
Message-ID: <86374jso77.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 Dec 2017 17:06:01 +0000,
Christoffer Dall wrote:
> 
> There is no need to figure out inside the world-switch if we should
> save/restore the debug registers or not, we can might as well do that in
> the higher level debug setup code, making it easier to optimize down the
> line.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.
