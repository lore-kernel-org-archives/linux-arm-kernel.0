From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 Apr 2016 14:43:59 +0200
Subject: [PATCH 05/17] kvm-arm: Replace kvm_pmd_huge with pmd_thp_or_huge
In-Reply-To: <1459787177-12767-6-git-send-email-suzuki.poulose@arm.com>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
 <1459787177-12767-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160408124359.GP8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 05:26:05PM +0100, Suzuki K Poulose wrote:
> Both arm and arm64 now provides a helper, pmd_thp_or_huge()
> to check if the given pmd represents a huge page. Use that
> instead of our own custom check.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
