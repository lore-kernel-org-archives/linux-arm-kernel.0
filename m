From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 08 Jun 2017 15:00:44 +0100
Subject: [PATCH v3 1/9] KVM: arm64: Allow creating the PMU without the
 in-kernel GIC
In-Reply-To: <20170608133446.3875-2-cdall@linaro.org> (Christoffer Dall's
 message of "Thu, 8 Jun 2017 15:34:38 +0200")
References: <20170608133446.3875-1-cdall@linaro.org>
 <20170608133446.3875-2-cdall@linaro.org>
Message-ID: <87fufainoz.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08 2017 at  3:34:38 pm BST, Christoffer Dall <cdall@linaro.org> wrote:
> Since we got support for devices in userspace which allows reporting the
> PMU overflow output status to userspace, we should actually allow
> creating the PMU on systems without an in-kernel irqchip, which in turn
> requires us to slightly clarify error codes for the ABI and move things
> around for the initialization phase.
>
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
