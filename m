From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 30 Aug 2015 18:53:00 +0200
Subject: [PATCH] arm64/kvm: set {v,}TCR_EL2 RES1 bits
In-Reply-To: <1440423725-31700-1-git-send-email-mark.rutland@arm.com>
References: <1440423725-31700-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20150830165300.GF24113@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 02:42:05PM +0100, Mark Rutland wrote:
> Currently we don't set the RES1 bits of TCR_EL2 and VTCR_EL2 when
> configuring them, which could lead to unexpected behaviour when an
> architectural meaning is defined for those bits.
> 
> Set the RES1 bits to avoid issues.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
