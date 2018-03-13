From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 13 Mar 2018 08:44:56 +0000
Subject: [PATCH v5 05/23] arm64: cpufeatures: Drop the
 ARM64_HYP_OFFSET_LOW feature flag
In-Reply-To: <20180301155538.26860-6-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-6-marc.zyngier@arm.com>
Message-ID: <666a9b42-0d35-b34f-8496-6d89b97acb15@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/18 15:55, Marc Zyngier wrote:
> Now that we can dynamically compute the kernek/hyp VA mask, there
> is no need for a feature flag to trigger the alternative patching.
> Let's drop the flag and everything that depends on it.
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm64/include/asm/cpucaps.h |  2 +-
>   arch/arm64/kernel/cpufeature.c   | 19 -------------------
>   2 files changed, 1 insertion(+), 20 deletions(-)
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
