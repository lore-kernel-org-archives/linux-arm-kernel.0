From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Jul 2013 16:43:38 +0100
Subject: [PATCH 1/2] ARM: mm: Remove general hugetlb code from ARM.
In-Reply-To: <1374067574-32034-2-git-send-email-steve.capper@linaro.org>
References: <1374067574-32034-1-git-send-email-steve.capper@linaro.org>
 <1374067574-32034-2-git-send-email-steve.capper@linaro.org>
Message-ID: <20130717154338.GI27948@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 02:26:13PM +0100, Steve Capper wrote:
> General forms of huge_pte_alloc, huge_pte_offset and follow_huge_pmd
> are now available in mm/hugetlb.c.
> 
> This patch removes the ARM copies of these functions and activates
> the general ones by enabling:
> CONFIG_ARCH_WANT_GENERAL_HUGETLB
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
