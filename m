From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 5 Nov 2013 09:47:26 -0500
Subject: [PATCH 3/3] ARM: fix mov to mvn conversion in case of 64 bit
 phys_addr_t and BE
In-Reply-To: <1383617765-28052-4-git-send-email-victor.kamensky@linaro.org>
References: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
 <1383617765-28052-4-git-send-email-victor.kamensky@linaro.org>
Message-ID: <527904FE.6070607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 November 2013 09:16 PM, Victor Kamensky wrote:
> Fix patching code to convert mov instruction into mvn instruction
> in case of CONFIG_ARCH_PHYS_ADDR_T_64BIT and CONFIG_ARM_PATCH_PHYS_VIRT.
> 
> In BE case store into r0 proper bits so byte swapped instruction
> could be modified correctly.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
Looks fine to me
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
