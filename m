From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 9 Oct 2017 18:06:06 +0100
Subject: [PATCH v3 08/20] KVM: arm/arm64: Rename soft timer to bg_timer
In-Reply-To: <20170923004207.22356-9-cdall@linaro.org>
References: <20170923004207.22356-1-cdall@linaro.org>
 <20170923004207.22356-9-cdall@linaro.org>
Message-ID: <cce9640b-8bdb-a9a3-7b31-4c136a424a0a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/09/17 01:41, Christoffer Dall wrote:
> As we are about to introduce a separate hrtimer for the physical timer,
> call this timer bg_timer, because we refer to this timer as the
> background timer in the code and comments elsewhere.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
