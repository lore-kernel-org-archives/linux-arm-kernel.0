From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 Apr 2016 15:16:05 +0200
Subject: [PATCH 11/17] kvm-arm: Use explicit stage2 helper routines
In-Reply-To: <1459787177-12767-12-git-send-email-suzuki.poulose@arm.com>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
 <1459787177-12767-12-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160408131605.GV8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 05:26:11PM +0100, Suzuki K Poulose wrote:
> We have stage2 page table helpers for both arm and arm64. Switch to
> the stage2 helpers for routines that only deal with stage2 page table.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
