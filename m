From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 Apr 2016 15:15:43 +0200
Subject: [PATCH 08/17] kvm-arm: arm: Introduce hyp page table empty checks
In-Reply-To: <1459787177-12767-9-git-send-email-suzuki.poulose@arm.com>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
 <1459787177-12767-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160408131543.GS8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 05:26:08PM +0100, Suzuki K Poulose wrote:
> Introduce hyp_pxx_table_empty helpers for checking whether
> a given table entry is empty. This will be used explicitly
> once we switch to explicit routines for hyp page table walk.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
