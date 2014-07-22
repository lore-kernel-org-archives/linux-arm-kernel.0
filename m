From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 23 Jul 2014 00:13:27 +0900
Subject: [PATCH 13/11] arm64: Add support for 48-bit VA space with 64KB
 page configuration
In-Reply-To: <AABDB416-D194-4825-8113-4748C10BC339@gmail.com>
References: <ADA477FA-165D-4679-A38F-C82C901BEE4D@gmail.com>
 <AABDB416-D194-4825-8113-4748C10BC339@gmail.com>
Message-ID: <2C360BFC-E4CF-448D-9110-4197DCAEAD4F@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 22, 2014, at 00:09 +900 Catalin Marinas wrote:
> This patch allows support for 3 levels of page tables with 64KB page 
> configuration allowing 48-bit VA space. The pgd is no longer a full 
> PAGE_SIZE (PTRS_PER_PGD is 64) and (swapper|idmap)_pg_dir are not fully 
> populated (pgd_alloc falls back to kzalloc). 
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com> 
> --- 

One more step :)

Are you going to post the next version of this series including [12/11]
and [13/11] or finalize the series?

In addition, could you put my gmail address in CC in coming patch or
the next version? It help me follow up the series easily.

- Jungseok Lee 
