From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Feb 2014 10:28:50 +0000
Subject: [PATCHv2] arm64: Align CMA sizes to PAGE_SIZE
In-Reply-To: <1391555337-25380-1-git-send-email-lauraa@codeaurora.org>
References: <1391555337-25380-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140205102850.GB4854@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 11:08:57PM +0000, Laura Abbott wrote:
> dma_alloc_from_contiguous takes number of pages for a size.
> Align up the dma size passed in to page size to avoid truncation
> and allocation failures on sizes less than PAGE_SIZE.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Thanks. Applied.

-- 
Catalin
