From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 Apr 2016 14:44:04 +0200
Subject: [PATCH 06/17] kvm-arm: Remove kvm_pud_huge()
In-Reply-To: <1459787177-12767-7-git-send-email-suzuki.poulose@arm.com>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
 <1459787177-12767-7-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160408124404.GQ8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 05:26:06PM +0100, Suzuki K Poulose wrote:
> Get rid of kvm_pud_huge() which falls back to pud_huge. Use
> pud_huge instead.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
