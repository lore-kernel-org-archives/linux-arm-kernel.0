From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Sep 2010 17:52:11 +0100
Subject: [PATCH] ARM: mmu: Fix MT_MEMORY and MT_MEMORY_NONCACHED pte flags
In-Reply-To: <1285778596-12560-1-git-send-email-santosh.shilimkar@ti.com>
References: <1285778596-12560-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1285779131.7983.93.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-09-29 at 17:43 +0100, Santosh Shilimkar wrote:
> The commit f1a2481c0 sets up the default flags for MT_MEMORY and
> MT_MEMORY_NONCACHED memory types. L_PTE_USER flag is wrongly
> set as default for these entries so remove it. Also adding
> the 'L_PTE_WRITE' flag so that these pages become read-write
> instead of just being read-only
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
