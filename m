From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 Apr 2016 17:05:30 +0200
Subject: [PATCH 14/17] kvm-arm: Cleanup kvm_* wrappers
In-Reply-To: <1459787177-12767-15-git-send-email-suzuki.poulose@arm.com>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
 <1459787177-12767-15-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160408150530.GY8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 05:26:14PM +0100, Suzuki K Poulose wrote:
> Now that we have switched to explicit page table routines,
> get rid of the obsolete kvm_* wrappers.
> 
> Also, kvm_tlb_flush_vmid_by_ipa is now called only on stage2
> page tables, hence get rid of the redundant check.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
