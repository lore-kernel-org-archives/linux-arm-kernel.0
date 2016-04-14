From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Apr 2016 15:12:24 +0100
Subject: [PATCH v2 02/17] arm64: Cleanup VTCR_EL2 and VTTBR field values
In-Reply-To: <1460640065-27658-3-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
 <1460640065-27658-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <570FA548.2070405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 14:20, Suzuki K Poulose wrote:
> We share most of the bits for VTCR_EL2 for different page sizes,
> except for the TG0 value and the entry level value. This patch
> makes the definitions a bit more cleaner to reflect this fact.
> 
> Also cleans up the VTTBR_X calculation. No functional changes.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
