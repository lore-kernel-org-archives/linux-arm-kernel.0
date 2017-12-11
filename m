From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Dec 2017 10:15:17 +0000
Subject: [PATCH v2 16/36] KVM: arm64: Rewrite sysreg alternatives to
 static keys
In-Reply-To: <20171207170630.592-17-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
 <20171207170630.592-17-christoffer.dall@linaro.org>
Message-ID: <75da7003-17d8-7a72-1f0c-4fbf7889c088@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/17 17:06, Christoffer Dall wrote:
> As we are about to move calls around in the sysreg save/restore logic,
> let's first rewrite the alternative function callers, because it is
> going to make the next patches much easier to read.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
