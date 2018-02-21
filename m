From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 21 Feb 2018 15:44:00 +0000
Subject: [PATCH v4 29/40] KVM: arm64: Prepare to handle deferred
 save/restore of 32-bit registers
In-Reply-To: <20180215210332.8648-30-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-30-christoffer.dall@linaro.org>
Message-ID: <86371ul54v.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Feb 2018 21:03:21 +0000,
Christoffer Dall wrote:
> 
> 32-bit registers are not used by a 64-bit host kernel and can be
> deferred, but we need to rework the accesses to this register to access
> the latest value depending on whether or not guest system registers are
> loaded on the CPU or only reside in memory.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Ah, much nicer than the "clunky" version! :-)

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.
