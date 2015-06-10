From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Jun 2015 17:56:11 +0100
Subject: [PATCH 15/15] arm64: remove ununsed set_irq_flags
In-Reply-To: <1433874401-27161-16-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-16-git-send-email-robh@kernel.org>
Message-ID: <20150610165610.GF22844@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 01:26:41PM -0500, Rob Herring wrote:
> Now that all users of set_irq_flags and custom flags are converted to
> genirq functions, the ARM specific set_irq_flags can be removed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm64/include/asm/hardirq.h | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
