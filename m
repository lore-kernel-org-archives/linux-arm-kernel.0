From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Apr 2016 15:45:25 +0100
Subject: [PATCH v2 10/17] kvm-arm: arm64: Introduce hyp page table empty
 checks
In-Reply-To: <1460640065-27658-11-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
 <1460640065-27658-11-git-send-email-suzuki.poulose@arm.com>
Message-ID: <570FAD05.7070901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 14:20, Suzuki K Poulose wrote:
> Introduce hyp_pxx_table_empty helpers for checking whether
> a given table entry is empty. This will be used explicitly
> once we switch to explicit routines for hyp page table walk.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
