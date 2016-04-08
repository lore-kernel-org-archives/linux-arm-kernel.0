From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 Apr 2016 15:15:49 +0200
Subject: [PATCH 09/17] kvm-arm: arm64: Introduce stage2 page table helpers
In-Reply-To: <1459787177-12767-10-git-send-email-suzuki.poulose@arm.com>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
 <1459787177-12767-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160408131549.GT8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 05:26:09PM +0100, Suzuki K Poulose wrote:
> Introduce stage2 page table helpers for arm64. With the fake
> page table level still in place, the stage2 table has the same
> number of levels as that of the host (and hyp), so they all
> fallback to the host version.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
