From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Aug 2014 11:55:51 +0100
Subject: [PATCH v14 7/8] arm64: add pmd_[dirty|mkclean] for THP
In-Reply-To: <1407981212-17818-8-git-send-email-minchan@kernel.org>
References: <1407981212-17818-1-git-send-email-minchan@kernel.org>
 <1407981212-17818-8-git-send-email-minchan@kernel.org>
Message-ID: <20140815105550.GL27466@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 02:53:31AM +0100, Minchan Kim wrote:
> MADV_FREE needs pmd_dirty and pmd_mkclean for detecting recent
> overwrite of the contents since MADV_FREE syscall is called for
> THP page.
> 
> This patch adds pmd_dirty and pmd_mkclean for THP page MADV_FREE
> support.

Acked-by: Will Deacon <will.deacon@arm.com>
