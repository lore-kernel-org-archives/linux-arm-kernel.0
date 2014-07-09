From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Jul 2014 12:14:47 +0100
Subject: [PATCH v12 7/8] arm64: add pmd_[dirty|mkclean] for THP
In-Reply-To: <1404886949-17695-8-git-send-email-minchan@kernel.org>
References: <1404886949-17695-1-git-send-email-minchan@kernel.org>
 <1404886949-17695-8-git-send-email-minchan@kernel.org>
Message-ID: <20140709111446.GE27270@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 07:22:28AM +0100, Minchan Kim wrote:
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
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
