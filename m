From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 22 May 2017 16:24:51 +0100
Subject: [PATCH v2 2/3] KVM: arm/arm64: Separate guest and uaccess writes
 to dist {sc}active
In-Reply-To: <20170516100431.4101-3-cdall@linaro.org>
References: <20170516100431.4101-1-cdall@linaro.org>
 <20170516100431.4101-3-cdall@linaro.org>
Message-ID: <eca50759-8682-d897-9ee1-22b285be8a54@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/17 11:04, Christoffer Dall wrote:
> Factor out the core register modifier functionality from the entry
> points from the register description table, and only call the
> prepare/finish functions from the guest path, not the uaccess path.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
