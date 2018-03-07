From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Mar 2018 18:11:51 +0000
Subject: [PATCH v5 05/23] arm64: cpufeatures: Drop the
 ARM64_HYP_OFFSET_LOW feature flag
In-Reply-To: <20180301155538.26860-6-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-6-marc.zyngier@arm.com>
Message-ID: <20180307181150.zoi3ote4ymjrntnw@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 03:55:20PM +0000, Marc Zyngier wrote:
> Now that we can dynamically compute the kernek/hyp VA mask, there
> is no need for a feature flag to trigger the alternative patching.
> Let's drop the flag and everything that depends on it.
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
