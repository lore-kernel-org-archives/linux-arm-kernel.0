From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 18 Jul 2014 15:55:07 +0100
Subject: [PATCH v13 7/8] arm64: add pmd_[dirty|mkclean] for THP
In-Reply-To: <1405666386-15095-8-git-send-email-minchan@kernel.org>
References: <1405666386-15095-1-git-send-email-minchan@kernel.org>
 <1405666386-15095-8-git-send-email-minchan@kernel.org>
Message-ID: <20140718145506.GB18569@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 03:53:05PM +0900, Minchan Kim wrote:
> MADV_FREE needs pmd_dirty and pmd_mkclean for detecting recent
> overwrite of the contents since MADV_FREE syscall is called for
> THP page.
> 
> This patch adds pmd_dirty and pmd_mkclean for THP page MADV_FREE
> support.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Steve Capper <steve.capper@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: Steve Capper <steve.capper@linaro.org> 
